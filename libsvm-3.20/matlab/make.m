% This make.m is for MATLAB and OCTAVE under Windows, Mac, and Unix

try
	Type = ver;
	% This part is for OCTAVE
	if(strcmp(Type(1).Name, 'Octave') == 1)
		mex libsvmread.c -Dchar16_t=uint16_t
		mex libsvmwrite.c -Dchar16_t=uint16_t
		mex svmtrain.c ../svm.cpp svm_model_matlab.c -Dchar16_t=uint16_t
		mex svmpredict.c ../svm.cpp svm_model_matlab.c -Dchar16_t=uint16_t
	% This part is for MATLAB
	% Add -largeArrayDims on 64-bit machines of MATLAB
	else
		mex CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmread.c -Dchar16_t=uint16_t
		mex CFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmwrite.c -Dchar16_t=uint16_t
		mex CFLAGS="\$CFLAGS -std=c99" -largeArrayDims svmtrain.c ../svm.cpp svm_model_matlab.c -Dchar16_t=uint16_t
		mex CFLAGS="\$CFLAGS -std=c99" -largeArrayDims svmpredict.c ../svm.cpp svm_model_matlab.c -Dchar16_t=uint16_t
	end
catch
	fprintf('If make.m fails, please check README about detailed instructions.\n');
end
