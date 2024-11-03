bits = [0 1 0 1 0 0 0 1];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));
lastbit = 1;

% Create a UI figure
figure('Name', 'Encoding Schemes', 'Color', 'white', 'Position', [100 100 900 800]);

dlg_title= '                  Welcome      ';
prompt = 'Select Encoding Scheme:';
encoding_options = {'Unipolar (NRZ)', 'Polar (NRZ, RZ, Manchester, Differential Manchester)', 'Bipolar (AMI, Pseudoternary)'};
[encodingSchemeIndex,~] = listdlg('PromptString',prompt,'SelectionMode','single','ListString',encoding_options,'Name',dlg_title);

switch encodingSchemeIndex
    case 1
        % Unipolar (NRZ)
        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n) = lastbit;
            else
                x((i-1)*n+1:i*n) = -lastbit;
            end
            lastbit = x((i-1)*n+1);
        end

        % Create axes for the plot
        axes('Position', [0.1 0.1 0.8 0.3]);
        plot(t, x, 'LineWidth', 3, 'Color', 'blue');
        axis([0 T -1.5 1.5]);
        title('Unipolar (NRZ)');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Unipolar (NRZ) - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == lastbit
                    result(counter) = 0;
                else
                    result(counter) = 1;
                end
            end
        end

        disp('Decode Result - Unipolar (NRZ):');
        disp(result);

    case 2
        % Polar (NRZ)
        x = zeros(1,length(t));
        lastbit = 1;

        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n) = -lastbit;
            else
                x((i-1)*n+1:i*n) = lastbit;
            end
            lastbit = x((i-1)*n+1);
        end

        % Create axes for the plot
        axes('Position', [0.1 0.7 0.8 0.15]);
        plot(t, x, 'LineWidth', 3, 'Color', 'red');
        axis([0 T -1.5 1.5]);
        title('Polar (NRZ)');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Polar (NRZ) - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == lastbit
                    result(counter) = 0;
                else
                    result(counter) = 1;
                end
            end
        end

        disp('Decode Result - Polar (NRZ):');
        disp(result);

        % Polar (RZ)
        x = zeros(1,length(t));
        lastbit = 1;

        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n-(n/2)) = -lastbit;
                x(i*n-(n/2)+1:i*n) = lastbit;
            else
                x((i-1)*n+1:i*n-(n/2)) = lastbit;
                x(i*n-(n/2)+1:i*n) = -lastbit;
            end
            lastbit = x(i*n);
        end

        % Create axes for the plot
        axes('Position', [0.1 0.5 0.8 0.15]);
        plot(t, x, 'LineWidth', 3, 'Color', 'green');
        axis([0 T -1.5 1.5]);
        title('Polar (RZ)');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Polar (RZ) - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == lastbit
                    result(counter) = 0;
                else
                    result(counter) = 1;
                end
            end
        end

        disp('Decode Result - Polar (RZ):');
        disp(result);

        % Manchester
        x = zeros(1,length(t));
        lastbit = 1;

        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n-(n/2)) = -lastbit;
                x(i*n-(n/2)+1:i*n) = lastbit;
            else
                x((i-1)*n+1:i*n-(n/2)) = lastbit;
                x(i*n-(n/2)+1:i*n) = -lastbit;
            end
            lastbit = -lastbit;
        end

        % Create axes for the plot
        axes('Position', [0.1 0.3 0.8 0.15]);
        plot(t, x, 'LineWidth', 3, 'Color', 'magenta');
        axis([0 T -1.5 1.5]);
        title('Manchester');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Manchester - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == lastbit
                    result(counter) = 0;
                else
                    result(counter) = 1;
                end
            end
        end

        disp('Decode Result - Manchester:');
        disp(result);

        % Differential Manchester
        x = zeros(1,length(t));
        lastbit = 1;

        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n-(n/2)) = lastbit;
                x(i*n-(n/2)+1:i*n) = -lastbit;
            else
                x((i-1)*n+1:i*n-(n/2)) = -lastbit;
                x(i*n-(n/2)+1:i*n) = lastbit;
            end
            lastbit = -lastbit;
        end

        % Create axes for the plot
        axes('Position', [0.1 0.1 0.8 0.15]);
        plot(t, x, 'LineWidth', 3, 'Color', 'blue');
        axis([0 T -1.5 1.5]);
        title('Differential Manchester');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Differential Manchester - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == lastbit
                    result(counter) = 1;
                else
                    result(counter) = 0;
                end
            end
        end

        disp('Decode Result - Differential Manchester:');
        disp(result);

       
    case 3
        % Bipolar (AMI)
        x = zeros(1,length(t));
        lastbit = 1;
        voltage = 1;

        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n) = 0;
            else
                x((i-1)*n+1:i*n) = lastbit * voltage;
                lastbit = -lastbit;
            end
        end

        % Create axes for the plot
        axes('Position', [0.1 0.55 0.8 0.25]);
        plot(t, x, 'LineWidth', 3, 'Color', 'cyan');
        axis([0 T -1.5 1.5]);
        title('Bipolar (AMI)');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Bipolar (AMI) - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == 0
                    result(counter) = 0;
                else
                    result(counter) = 1;
                end
            end
        end

        disp('Decode Result - Bipolar (AMI):');
        disp(result);

        % Bipolar (Pseudoternary)
        x = zeros(1,length(t));
        lastbit = -1;
        voltage = 1;

        for i=1:length(bits)
            if bits(i)==0
                x((i-1)*n+1:i*n) = lastbit * voltage;
            else
                x((i-1)*n+1:i*n) = 0;
                lastbit = -lastbit;
            end
        end

        % Create axes for the plot
        axes('Position', [0.1 0.2 0.8 0.25]);
        plot(t, x, 'LineWidth', 3, 'Color', 'blue');
        axis([0 T -1.5 1.5]);
        title('Bipolar (Pseudoternary)');
        xlabel('Time');
        ylabel('Amplitude');

        counter = 0;
        lastbit = 1;
        result = zeros(1, length(bits));

        % Bipolar (Pseudoternary) - Decode
        for i = 1:length(t)
            if t(i) > counter
                counter = counter + 1;
                if x(i) == 0
                    result(counter) = 1;
                else
                    result(counter) = 0;
                end
            end
        end

        disp('Decode Result - Bipolar (Pseudoternary):');
        disp(result);

end
