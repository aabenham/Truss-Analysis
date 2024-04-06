function TrussCalc(C, Sx, Sy, X, Y, L)
    % Truss Analysis Function
    [joints, members] = size(C); % Determine the size of the truss

    Support_Forces = [Sx ; Sy]; % Define support forces

    Member_Matrix = zeros(2 * joints, members); % Initialize member matrix

    Pcrit = zeros(1, members); % Initialize critical load array

    W_failure = zeros(members, 3); % Initialize weight failure matrix

    totalLen = 0; % Total length of all members
    
    disp('MEMBER LENGTHS AND BUCKLING WEIGHTS:')
    fprintf('Member\t\t\tLength(in)\tP_crit(oz)\n'); % Header for output

    for m = 1:members
        % Find the two joints for each member
        jointIndices = find(C(:,m) == 1);

        % Calculate distances between the joints
        dX = X(jointIndices(2)) - X(jointIndices(1));
        dY = Y(jointIndices(2)) - Y(jointIndices(1));
        R = sqrt(dX^2 + dY^2);
        totalLen = totalLen + R;

        % Pcrit calculations
        Pcrit(m) = 3054.789 / (R^2);

        % Weight Failure of the member
        W_failure(m,:) = [Pcrit(m), Pcrit(m) - 1.36, Pcrit(m) + 1.36];

        % Method of joints calculations
        Member_Matrix(jointIndices(1), m) = dX / R;
        Member_Matrix(jointIndices(2), m) = -dX / R; 
        Member_Matrix(joints + jointIndices(1), m) = dY / R;
        Member_Matrix(joints + jointIndices(2), m) = -dY / R; 

        % Output member details
        fprintf('Member %d:\t\t%.3f\t\t%.3f\n', m, R, Pcrit(m));
    end


    A = [Member_Matrix Support_Forces]; % A matrix
    T = inv(A) * L; % T matrix

    % Displaying results
    disp('EK301, Section A1, Group: Anas B., Westerly G., 03/29/2024');
    totalLoad = sum(L);
    fprintf('Load: %.2foz\nMember forces in oz:\n', totalLoad);
    
    for i = 1:length(T)
        type = 'Z'; % Zero force
        if T(i) < 0, type = 'C'; end % Compression
        if T(i) > 0, type = 'T'; end % Tension
        if i <= members
            fprintf('m%d\t%.3f\t(%s)\n', i, T(i), type);
        else
            fprintf('Reaction force S%d: %.3f\n', i - members, T(i));
        end
    end
    
    % Calculate Maximum Theoretical Load

    % Identify load application points (assuming you start with some non-zero loads)
    loadPoints = find(L ~= 0);

    % Initialize variables for the loop
    maxLoadReached = false;
    loadIncrement = 1; % This is the load increment for each step

    while ~maxLoadReached
        % Increment load at all points identified for load application
        L(loadPoints) = L(loadPoints) + loadIncrement;
    
        % Recalculate forces in the truss members with the incremented load
        A = [Member_Matrix, Support_Forces]; % A matrix may need to be recalculated if supports are load-dependent
        T = inv(A) * L; % T matrix for the new load
    
        % Check each member to see if it's under compression and nearing buckling
        for i = 1:members
            if T(i) < 0 % Member is in compression
                % Check if the compressive force is equal to or greater than the buckling load
                if abs(T(i)) >= Pcrit(i)
                    maxLoadReached = true;
                    % Subtract the last increment since it caused buckling
                    L(loadPoints) = L(loadPoints) - loadIncrement;
                    maxLoad = sum(L); % The maximum load before buckling
                    break; % Exit the loop since maximum load has been found
                end
            end
        end
    
        if maxLoadReached
            break; % Exit the while loop since maximum load has been found
        end
    end


    cost = 10 * joints + totalLen; % Cost calculation
    fprintf('Cost of truss: $%.2f\n', cost);
    fprintf('Theoretical max load/cost ratio in oz/$: %.4f\n', maxLoad / cost);
    
    
    % Display failure weights
    disp('BUCKLING WEIGHTS:');
    for m = 1:members
        fprintf('Member %d:\t%.2f +/- %.2f oz\n', m, W_failure(m, 1), W_failure(m, 3) - W_failure(m, 2));
    end




    
    % Display the maximum theoretical load
    fprintf('Maximum Theoretical Load before Buckling: %.2f oz\n', maxLoad);




end
