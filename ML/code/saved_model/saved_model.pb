Ұ
??
8
Const
output"dtype"
valuetensor"
dtypetype

NoOp
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
@
ReadVariableOp
resource
value"dtype"
dtypetype?
?
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ?
q
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape?"serve*2.0.02unknown8??	
y
dense_5/kernelVarHandleOp*
shape:	?p*
dtype0*
_output_shapes
: *
shared_namedense_5/kernel
r
"dense_5/kernel/Read/ReadVariableOpReadVariableOpdense_5/kernel*
_output_shapes
:	?p*
dtype0
p
dense_5/biasVarHandleOp*
shared_namedense_5/bias*
dtype0*
_output_shapes
: *
shape:
i
 dense_5/bias/Read/ReadVariableOpReadVariableOpdense_5/bias*
_output_shapes
:*
dtype0
x
dense_6/kernelVarHandleOp*
shape
:
*
_output_shapes
: *
dtype0*
shared_namedense_6/kernel
q
"dense_6/kernel/Read/ReadVariableOpReadVariableOpdense_6/kernel*
dtype0*
_output_shapes

:

p
dense_6/biasVarHandleOp*
dtype0*
shape:
*
_output_shapes
: *
shared_namedense_6/bias
i
 dense_6/bias/Read/ReadVariableOpReadVariableOpdense_6/bias*
dtype0*
_output_shapes
:

y
dense_7/kernelVarHandleOp*
_output_shapes
: *
shared_namedense_7/kernel*
shape:	
?*
dtype0
r
"dense_7/kernel/Read/ReadVariableOpReadVariableOpdense_7/kernel*
dtype0*
_output_shapes
:	
?
q
dense_7/biasVarHandleOp*
_output_shapes
: *
dtype0*
shared_namedense_7/bias*
shape:?
j
 dense_7/bias/Read/ReadVariableOpReadVariableOpdense_7/bias*
dtype0*
_output_shapes	
:?
?
batch_normalization_1/gammaVarHandleOp*
_output_shapes
: *
dtype0*
shape:?*,
shared_namebatch_normalization_1/gamma
?
/batch_normalization_1/gamma/Read/ReadVariableOpReadVariableOpbatch_normalization_1/gamma*
dtype0*
_output_shapes	
:?
?
batch_normalization_1/betaVarHandleOp*
dtype0*
shape:?*
_output_shapes
: *+
shared_namebatch_normalization_1/beta
?
.batch_normalization_1/beta/Read/ReadVariableOpReadVariableOpbatch_normalization_1/beta*
dtype0*
_output_shapes	
:?
?
!batch_normalization_1/moving_meanVarHandleOp*
dtype0*2
shared_name#!batch_normalization_1/moving_mean*
_output_shapes
: *
shape:?
?
5batch_normalization_1/moving_mean/Read/ReadVariableOpReadVariableOp!batch_normalization_1/moving_mean*
_output_shapes	
:?*
dtype0
?
%batch_normalization_1/moving_varianceVarHandleOp*
shape:?*
dtype0*6
shared_name'%batch_normalization_1/moving_variance*
_output_shapes
: 
?
9batch_normalization_1/moving_variance/Read/ReadVariableOpReadVariableOp%batch_normalization_1/moving_variance*
dtype0*
_output_shapes	
:?
y
dense_8/kernelVarHandleOp*
dtype0*
shared_namedense_8/kernel*
shape:	?*
_output_shapes
: 
r
"dense_8/kernel/Read/ReadVariableOpReadVariableOpdense_8/kernel*
_output_shapes
:	?*
dtype0
p
dense_8/biasVarHandleOp*
shared_namedense_8/bias*
shape:*
_output_shapes
: *
dtype0
i
 dense_8/bias/Read/ReadVariableOpReadVariableOpdense_8/bias*
_output_shapes
:*
dtype0
|
training_1/Adam/iterVarHandleOp*
_output_shapes
: *
dtype0	*%
shared_nametraining_1/Adam/iter*
shape: 
u
(training_1/Adam/iter/Read/ReadVariableOpReadVariableOptraining_1/Adam/iter*
dtype0	*
_output_shapes
: 
?
training_1/Adam/beta_1VarHandleOp*
shape: *'
shared_nametraining_1/Adam/beta_1*
_output_shapes
: *
dtype0
y
*training_1/Adam/beta_1/Read/ReadVariableOpReadVariableOptraining_1/Adam/beta_1*
_output_shapes
: *
dtype0
?
training_1/Adam/beta_2VarHandleOp*
_output_shapes
: *
shape: *
dtype0*'
shared_nametraining_1/Adam/beta_2
y
*training_1/Adam/beta_2/Read/ReadVariableOpReadVariableOptraining_1/Adam/beta_2*
dtype0*
_output_shapes
: 
~
training_1/Adam/decayVarHandleOp*
dtype0*&
shared_nametraining_1/Adam/decay*
_output_shapes
: *
shape: 
w
)training_1/Adam/decay/Read/ReadVariableOpReadVariableOptraining_1/Adam/decay*
dtype0*
_output_shapes
: 
?
training_1/Adam/learning_rateVarHandleOp*
_output_shapes
: *.
shared_nametraining_1/Adam/learning_rate*
dtype0*
shape: 
?
1training_1/Adam/learning_rate/Read/ReadVariableOpReadVariableOptraining_1/Adam/learning_rate*
dtype0*
_output_shapes
: 
^
totalVarHandleOp*
shared_nametotal*
dtype0*
_output_shapes
: *
shape: 
W
total/Read/ReadVariableOpReadVariableOptotal*
dtype0*
_output_shapes
: 
^
countVarHandleOp*
shared_namecount*
dtype0*
_output_shapes
: *
shape: 
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
?
 training_1/Adam/dense_5/kernel/mVarHandleOp*
_output_shapes
: *
shape:	?p*1
shared_name" training_1/Adam/dense_5/kernel/m*
dtype0
?
4training_1/Adam/dense_5/kernel/m/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_5/kernel/m*
_output_shapes
:	?p*
dtype0
?
training_1/Adam/dense_5/bias/mVarHandleOp*/
shared_name training_1/Adam/dense_5/bias/m*
_output_shapes
: *
shape:*
dtype0
?
2training_1/Adam/dense_5/bias/m/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_5/bias/m*
dtype0*
_output_shapes
:
?
 training_1/Adam/dense_6/kernel/mVarHandleOp*1
shared_name" training_1/Adam/dense_6/kernel/m*
_output_shapes
: *
dtype0*
shape
:

?
4training_1/Adam/dense_6/kernel/m/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_6/kernel/m*
_output_shapes

:
*
dtype0
?
training_1/Adam/dense_6/bias/mVarHandleOp*/
shared_name training_1/Adam/dense_6/bias/m*
_output_shapes
: *
shape:
*
dtype0
?
2training_1/Adam/dense_6/bias/m/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_6/bias/m*
_output_shapes
:
*
dtype0
?
 training_1/Adam/dense_7/kernel/mVarHandleOp*
_output_shapes
: *
dtype0*
shape:	
?*1
shared_name" training_1/Adam/dense_7/kernel/m
?
4training_1/Adam/dense_7/kernel/m/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_7/kernel/m*
dtype0*
_output_shapes
:	
?
?
training_1/Adam/dense_7/bias/mVarHandleOp*
dtype0*
_output_shapes
: */
shared_name training_1/Adam/dense_7/bias/m*
shape:?
?
2training_1/Adam/dense_7/bias/m/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_7/bias/m*
dtype0*
_output_shapes	
:?
?
-training_1/Adam/batch_normalization_1/gamma/mVarHandleOp*
_output_shapes
: *>
shared_name/-training_1/Adam/batch_normalization_1/gamma/m*
dtype0*
shape:?
?
Atraining_1/Adam/batch_normalization_1/gamma/m/Read/ReadVariableOpReadVariableOp-training_1/Adam/batch_normalization_1/gamma/m*
dtype0*
_output_shapes	
:?
?
,training_1/Adam/batch_normalization_1/beta/mVarHandleOp*
shape:?*
_output_shapes
: *=
shared_name.,training_1/Adam/batch_normalization_1/beta/m*
dtype0
?
@training_1/Adam/batch_normalization_1/beta/m/Read/ReadVariableOpReadVariableOp,training_1/Adam/batch_normalization_1/beta/m*
dtype0*
_output_shapes	
:?
?
 training_1/Adam/dense_8/kernel/mVarHandleOp*1
shared_name" training_1/Adam/dense_8/kernel/m*
_output_shapes
: *
dtype0*
shape:	?
?
4training_1/Adam/dense_8/kernel/m/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_8/kernel/m*
dtype0*
_output_shapes
:	?
?
training_1/Adam/dense_8/bias/mVarHandleOp*
shape:*/
shared_name training_1/Adam/dense_8/bias/m*
_output_shapes
: *
dtype0
?
2training_1/Adam/dense_8/bias/m/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_8/bias/m*
_output_shapes
:*
dtype0
?
 training_1/Adam/dense_5/kernel/vVarHandleOp*
_output_shapes
: *
shape:	?p*1
shared_name" training_1/Adam/dense_5/kernel/v*
dtype0
?
4training_1/Adam/dense_5/kernel/v/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_5/kernel/v*
dtype0*
_output_shapes
:	?p
?
training_1/Adam/dense_5/bias/vVarHandleOp*/
shared_name training_1/Adam/dense_5/bias/v*
_output_shapes
: *
dtype0*
shape:
?
2training_1/Adam/dense_5/bias/v/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_5/bias/v*
_output_shapes
:*
dtype0
?
 training_1/Adam/dense_6/kernel/vVarHandleOp*1
shared_name" training_1/Adam/dense_6/kernel/v*
_output_shapes
: *
dtype0*
shape
:

?
4training_1/Adam/dense_6/kernel/v/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_6/kernel/v*
_output_shapes

:
*
dtype0
?
training_1/Adam/dense_6/bias/vVarHandleOp*
dtype0*/
shared_name training_1/Adam/dense_6/bias/v*
shape:
*
_output_shapes
: 
?
2training_1/Adam/dense_6/bias/v/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_6/bias/v*
_output_shapes
:
*
dtype0
?
 training_1/Adam/dense_7/kernel/vVarHandleOp*
_output_shapes
: *
shape:	
?*1
shared_name" training_1/Adam/dense_7/kernel/v*
dtype0
?
4training_1/Adam/dense_7/kernel/v/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_7/kernel/v*
_output_shapes
:	
?*
dtype0
?
training_1/Adam/dense_7/bias/vVarHandleOp*
shape:?*
dtype0*/
shared_name training_1/Adam/dense_7/bias/v*
_output_shapes
: 
?
2training_1/Adam/dense_7/bias/v/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_7/bias/v*
_output_shapes	
:?*
dtype0
?
-training_1/Adam/batch_normalization_1/gamma/vVarHandleOp*>
shared_name/-training_1/Adam/batch_normalization_1/gamma/v*
shape:?*
_output_shapes
: *
dtype0
?
Atraining_1/Adam/batch_normalization_1/gamma/v/Read/ReadVariableOpReadVariableOp-training_1/Adam/batch_normalization_1/gamma/v*
dtype0*
_output_shapes	
:?
?
,training_1/Adam/batch_normalization_1/beta/vVarHandleOp*
shape:?*
_output_shapes
: *
dtype0*=
shared_name.,training_1/Adam/batch_normalization_1/beta/v
?
@training_1/Adam/batch_normalization_1/beta/v/Read/ReadVariableOpReadVariableOp,training_1/Adam/batch_normalization_1/beta/v*
_output_shapes	
:?*
dtype0
?
 training_1/Adam/dense_8/kernel/vVarHandleOp*
shape:	?*
_output_shapes
: *1
shared_name" training_1/Adam/dense_8/kernel/v*
dtype0
?
4training_1/Adam/dense_8/kernel/v/Read/ReadVariableOpReadVariableOp training_1/Adam/dense_8/kernel/v*
dtype0*
_output_shapes
:	?
?
training_1/Adam/dense_8/bias/vVarHandleOp*
shape:*
dtype0*
_output_shapes
: */
shared_name training_1/Adam/dense_8/bias/v
?
2training_1/Adam/dense_8/bias/v/Read/ReadVariableOpReadVariableOptraining_1/Adam/dense_8/bias/v*
dtype0*
_output_shapes
:

NoOpNoOp
??
ConstConst"/device:CPU:0*?>
value?>B?> B?>
?
layer-0
layer_with_weights-0
layer-1
layer_with_weights-1
layer-2
layer_with_weights-2
layer-3
layer_with_weights-3
layer-4
layer-5
layer_with_weights-4
layer-6
	optimizer
	trainable_variables

	variables
regularization_losses
	keras_api

signatures
R
trainable_variables
	variables
regularization_losses
	keras_api
h

kernel
bias
trainable_variables
	variables
regularization_losses
	keras_api
h

kernel
bias
trainable_variables
	variables
regularization_losses
	keras_api
h

kernel
bias
 trainable_variables
!	variables
"regularization_losses
#	keras_api
?
$axis
	%gamma
&beta
'moving_mean
(moving_variance
)trainable_variables
*	variables
+regularization_losses
,	keras_api
R
-trainable_variables
.	variables
/regularization_losses
0	keras_api
h

1kernel
2bias
3trainable_variables
4	variables
5regularization_losses
6	keras_api
?
7iter

8beta_1

9beta_2
	:decay
;learning_ratemhmimjmkmlmm%mn&mo1mp2mqvrvsvtvuvvvw%vx&vy1vz2v{
F
0
1
2
3
4
5
%6
&7
18
29
V
0
1
2
3
4
5
%6
&7
'8
(9
110
211
 
?
	trainable_variables

<layers

	variables
regularization_losses
=non_trainable_variables
>metrics
?layer_regularization_losses
 
 
 
 
?
trainable_variables

@layers
	variables
Anon_trainable_variables
regularization_losses
Bmetrics
Clayer_regularization_losses
ZX
VARIABLE_VALUEdense_5/kernel6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE
VT
VARIABLE_VALUEdense_5/bias4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1

0
1
 
?
trainable_variables

Dlayers
	variables
Enon_trainable_variables
regularization_losses
Fmetrics
Glayer_regularization_losses
ZX
VARIABLE_VALUEdense_6/kernel6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUE
VT
VARIABLE_VALUEdense_6/bias4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1

0
1
 
?
trainable_variables

Hlayers
	variables
Inon_trainable_variables
regularization_losses
Jmetrics
Klayer_regularization_losses
ZX
VARIABLE_VALUEdense_7/kernel6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE
VT
VARIABLE_VALUEdense_7/bias4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUE

0
1

0
1
 
?
 trainable_variables

Llayers
!	variables
Mnon_trainable_variables
"regularization_losses
Nmetrics
Olayer_regularization_losses
 
fd
VARIABLE_VALUEbatch_normalization_1/gamma5layer_with_weights-3/gamma/.ATTRIBUTES/VARIABLE_VALUE
db
VARIABLE_VALUEbatch_normalization_1/beta4layer_with_weights-3/beta/.ATTRIBUTES/VARIABLE_VALUE
rp
VARIABLE_VALUE!batch_normalization_1/moving_mean;layer_with_weights-3/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUE%batch_normalization_1/moving_variance?layer_with_weights-3/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

%0
&1

%0
&1
'2
(3
 
?
)trainable_variables

Players
*	variables
Qnon_trainable_variables
+regularization_losses
Rmetrics
Slayer_regularization_losses
 
 
 
?
-trainable_variables

Tlayers
.	variables
Unon_trainable_variables
/regularization_losses
Vmetrics
Wlayer_regularization_losses
ZX
VARIABLE_VALUEdense_8/kernel6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUE
VT
VARIABLE_VALUEdense_8/bias4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUE

10
21

10
21
 
?
3trainable_variables

Xlayers
4	variables
Ynon_trainable_variables
5regularization_losses
Zmetrics
[layer_regularization_losses
SQ
VARIABLE_VALUEtraining_1/Adam/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE
WU
VARIABLE_VALUEtraining_1/Adam/beta_1+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUE
WU
VARIABLE_VALUEtraining_1/Adam/beta_2+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUE
US
VARIABLE_VALUEtraining_1/Adam/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE
ec
VARIABLE_VALUEtraining_1/Adam/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE
*
0
1
2
3
4
5

'0
(1

\0
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

'0
(1
 
 
 
 
 
 
 
 
 
 
x
	]total
	^count
_
_fn_kwargs
`trainable_variables
a	variables
bregularization_losses
c	keras_api
OM
VARIABLE_VALUEtotal4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE
OM
VARIABLE_VALUEcount4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE
 
 

]0
^1
 
?
`trainable_variables

dlayers
a	variables
enon_trainable_variables
bregularization_losses
fmetrics
glayer_regularization_losses
 

]0
^1
 
 
??
VARIABLE_VALUE training_1/Adam/dense_5/kernel/mRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_5/bias/mPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_6/kernel/mRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_6/bias/mPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_7/kernel/mRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_7/bias/mPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE-training_1/Adam/batch_normalization_1/gamma/mQlayer_with_weights-3/gamma/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE,training_1/Adam/batch_normalization_1/beta/mPlayer_with_weights-3/beta/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_8/kernel/mRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_8/bias/mPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_5/kernel/vRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_5/bias/vPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_6/kernel/vRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_6/bias/vPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_7/kernel/vRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_7/bias/vPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE-training_1/Adam/batch_normalization_1/gamma/vQlayer_with_weights-3/gamma/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE,training_1/Adam/batch_normalization_1/beta/vPlayer_with_weights-3/beta/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUE training_1/Adam/dense_8/kernel/vRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE
??
VARIABLE_VALUEtraining_1/Adam/dense_8/bias/vPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
dtype0*
_output_shapes
: 
?
serving_default_dense_5_inputPlaceholder*
dtype0*(
_output_shapes
:??????????p*
shape:??????????p
?
StatefulPartitionedCallStatefulPartitionedCallserving_default_dense_5_inputdense_5/kerneldense_5/biasdense_6/kerneldense_6/biasdense_7/kerneldense_7/bias%batch_normalization_1/moving_variancebatch_normalization_1/gamma!batch_normalization_1/moving_meanbatch_normalization_1/betadense_8/kerneldense_8/bias**
config_proto

CPU

GPU 2J 8*-
f(R&
$__inference_signature_wrapper_250007*
Tout
2*'
_output_shapes
:?????????*
Tin
2*-
_gradient_op_typePartitionedCall-250489
O
saver_filenamePlaceholder*
shape: *
_output_shapes
: *
dtype0
?
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename"dense_5/kernel/Read/ReadVariableOp dense_5/bias/Read/ReadVariableOp"dense_6/kernel/Read/ReadVariableOp dense_6/bias/Read/ReadVariableOp"dense_7/kernel/Read/ReadVariableOp dense_7/bias/Read/ReadVariableOp/batch_normalization_1/gamma/Read/ReadVariableOp.batch_normalization_1/beta/Read/ReadVariableOp5batch_normalization_1/moving_mean/Read/ReadVariableOp9batch_normalization_1/moving_variance/Read/ReadVariableOp"dense_8/kernel/Read/ReadVariableOp dense_8/bias/Read/ReadVariableOp(training_1/Adam/iter/Read/ReadVariableOp*training_1/Adam/beta_1/Read/ReadVariableOp*training_1/Adam/beta_2/Read/ReadVariableOp)training_1/Adam/decay/Read/ReadVariableOp1training_1/Adam/learning_rate/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOp4training_1/Adam/dense_5/kernel/m/Read/ReadVariableOp2training_1/Adam/dense_5/bias/m/Read/ReadVariableOp4training_1/Adam/dense_6/kernel/m/Read/ReadVariableOp2training_1/Adam/dense_6/bias/m/Read/ReadVariableOp4training_1/Adam/dense_7/kernel/m/Read/ReadVariableOp2training_1/Adam/dense_7/bias/m/Read/ReadVariableOpAtraining_1/Adam/batch_normalization_1/gamma/m/Read/ReadVariableOp@training_1/Adam/batch_normalization_1/beta/m/Read/ReadVariableOp4training_1/Adam/dense_8/kernel/m/Read/ReadVariableOp2training_1/Adam/dense_8/bias/m/Read/ReadVariableOp4training_1/Adam/dense_5/kernel/v/Read/ReadVariableOp2training_1/Adam/dense_5/bias/v/Read/ReadVariableOp4training_1/Adam/dense_6/kernel/v/Read/ReadVariableOp2training_1/Adam/dense_6/bias/v/Read/ReadVariableOp4training_1/Adam/dense_7/kernel/v/Read/ReadVariableOp2training_1/Adam/dense_7/bias/v/Read/ReadVariableOpAtraining_1/Adam/batch_normalization_1/gamma/v/Read/ReadVariableOp@training_1/Adam/batch_normalization_1/beta/v/Read/ReadVariableOp4training_1/Adam/dense_8/kernel/v/Read/ReadVariableOp2training_1/Adam/dense_8/bias/v/Read/ReadVariableOpConst*4
Tin-
+2)	**
config_proto

CPU

GPU 2J 8*(
f#R!
__inference__traced_save_250549*
Tout
2*-
_gradient_op_typePartitionedCall-250550*
_output_shapes
: 
?

StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamedense_5/kerneldense_5/biasdense_6/kerneldense_6/biasdense_7/kerneldense_7/biasbatch_normalization_1/gammabatch_normalization_1/beta!batch_normalization_1/moving_mean%batch_normalization_1/moving_variancedense_8/kerneldense_8/biastraining_1/Adam/itertraining_1/Adam/beta_1training_1/Adam/beta_2training_1/Adam/decaytraining_1/Adam/learning_ratetotalcount training_1/Adam/dense_5/kernel/mtraining_1/Adam/dense_5/bias/m training_1/Adam/dense_6/kernel/mtraining_1/Adam/dense_6/bias/m training_1/Adam/dense_7/kernel/mtraining_1/Adam/dense_7/bias/m-training_1/Adam/batch_normalization_1/gamma/m,training_1/Adam/batch_normalization_1/beta/m training_1/Adam/dense_8/kernel/mtraining_1/Adam/dense_8/bias/m training_1/Adam/dense_5/kernel/vtraining_1/Adam/dense_5/bias/v training_1/Adam/dense_6/kernel/vtraining_1/Adam/dense_6/bias/v training_1/Adam/dense_7/kernel/vtraining_1/Adam/dense_7/bias/v-training_1/Adam/batch_normalization_1/gamma/v,training_1/Adam/batch_normalization_1/beta/v training_1/Adam/dense_8/kernel/vtraining_1/Adam/dense_8/bias/v*+
f&R$
"__inference__traced_restore_250679*
_output_shapes
: *-
_gradient_op_typePartitionedCall-250680**
config_proto

CPU

GPU 2J 8*3
Tin,
*2(*
Tout
2??
?
c
E__inference_dropout_1_layer_call_and_return_conditional_losses_250379

inputs

identity_1O
IdentityIdentityinputs*
T0*(
_output_shapes
:??????????\

Identity_1IdentityIdentity:output:0*
T0*(
_output_shapes
:??????????"!

identity_1Identity_1:output:0*'
_input_shapes
:??????????:& "
 
_user_specified_nameinputs
?
?
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249647

inputs%
!batchnorm_readvariableop_resource)
%batchnorm_mul_readvariableop_resource'
#batchnorm_readvariableop_1_resource'
#batchnorm_readvariableop_2_resource
identity??batchnorm/ReadVariableOp?batchnorm/ReadVariableOp_1?batchnorm/ReadVariableOp_2?batchnorm/mul/ReadVariableOpN
LogicalAnd/xConst*
_output_shapes
: *
value	B
 Z *
dtype0
N
LogicalAnd/yConst*
dtype0
*
_output_shapes
: *
value	B
 Z^

LogicalAnd
LogicalAndLogicalAnd/x:output:0LogicalAnd/y:output:0*
_output_shapes
: ?
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0T
batchnorm/add/yConst*
valueB
 *o?:*
_output_shapes
: *
dtype0x
batchnorm/addAddV2 batchnorm/ReadVariableOp:value:0batchnorm/add/y:output:0*
T0*
_output_shapes	
:?Q
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes	
:??
batchnorm/mul/ReadVariableOpReadVariableOp%batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0u
batchnorm/mulMulbatchnorm/Rsqrt:y:0$batchnorm/mul/ReadVariableOp:value:0*
T0*
_output_shapes	
:?d
batchnorm/mul_1Mulinputsbatchnorm/mul:z:0*(
_output_shapes
:??????????*
T0?
batchnorm/ReadVariableOp_1ReadVariableOp#batchnorm_readvariableop_1_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?s
batchnorm/mul_2Mul"batchnorm/ReadVariableOp_1:value:0batchnorm/mul:z:0*
T0*
_output_shapes	
:??
batchnorm/ReadVariableOp_2ReadVariableOp#batchnorm_readvariableop_2_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?s
batchnorm/subSub"batchnorm/ReadVariableOp_2:value:0batchnorm/mul_2:z:0*
T0*
_output_shapes	
:?s
batchnorm/add_1AddV2batchnorm/mul_1:z:0batchnorm/sub:z:0*(
_output_shapes
:??????????*
T0?
IdentityIdentitybatchnorm/add_1:z:0^batchnorm/ReadVariableOp^batchnorm/ReadVariableOp_1^batchnorm/ReadVariableOp_2^batchnorm/mul/ReadVariableOp*(
_output_shapes
:??????????*
T0"
identityIdentity:output:0*7
_input_shapes&
$:??????????::::28
batchnorm/ReadVariableOp_1batchnorm/ReadVariableOp_128
batchnorm/ReadVariableOp_2batchnorm/ReadVariableOp_224
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp2<
batchnorm/mul/ReadVariableOpbatchnorm/mul/ReadVariableOp: :& "
 
_user_specified_nameinputs: : : 
??
?
H__inference_sequential_8_layer_call_and_return_conditional_losses_250094

inputs*
&dense_5_matmul_readvariableop_resource+
'dense_5_biasadd_readvariableop_resource*
&dense_6_matmul_readvariableop_resource+
'dense_6_biasadd_readvariableop_resource*
&dense_7_matmul_readvariableop_resource+
'dense_7_biasadd_readvariableop_resourceF
Bbatch_normalization_1_assignmovingavg_read_readvariableop_resourceH
Dbatch_normalization_1_assignmovingavg_1_read_readvariableop_resource?
;batch_normalization_1_batchnorm_mul_readvariableop_resource;
7batch_normalization_1_batchnorm_readvariableop_resource*
&dense_8_matmul_readvariableop_resource+
'dense_8_biasadd_readvariableop_resource
identity??9batch_normalization_1/AssignMovingAvg/AssignSubVariableOp?9batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp?4batch_normalization_1/AssignMovingAvg/ReadVariableOp?;batch_normalization_1/AssignMovingAvg_1/AssignSubVariableOp?;batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp?6batch_normalization_1/AssignMovingAvg_1/ReadVariableOp?.batch_normalization_1/batchnorm/ReadVariableOp?2batch_normalization_1/batchnorm/mul/ReadVariableOp?dense_5/BiasAdd/ReadVariableOp?dense_5/MatMul/ReadVariableOp?dense_6/BiasAdd/ReadVariableOp?dense_6/MatMul/ReadVariableOp?dense_7/BiasAdd/ReadVariableOp?dense_7/MatMul/ReadVariableOp?dense_8/BiasAdd/ReadVariableOp?dense_8/MatMul/ReadVariableOp?
dense_5/MatMul/ReadVariableOpReadVariableOp&dense_5_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	?py
dense_5/MatMulMatMulinputs%dense_5/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
dense_5/BiasAdd/ReadVariableOpReadVariableOp'dense_5_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:?
dense_5/BiasAddBiasAdddense_5/MatMul:product:0&dense_5/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????`
dense_5/ReluReludense_5/BiasAdd:output:0*
T0*'
_output_shapes
:??????????
dense_6/MatMul/ReadVariableOpReadVariableOp&dense_6_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes

:
*
dtype0?
dense_6/MatMulMatMuldense_5/Relu:activations:0%dense_6/MatMul/ReadVariableOp:value:0*'
_output_shapes
:?????????
*
T0?
dense_6/BiasAdd/ReadVariableOpReadVariableOp'dense_6_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:
*
dtype0?
dense_6/BiasAddBiasAdddense_6/MatMul:product:0&dense_6/BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????
*
T0`
dense_6/TanhTanhdense_6/BiasAdd:output:0*'
_output_shapes
:?????????
*
T0?
dense_7/MatMul/ReadVariableOpReadVariableOp&dense_7_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	
?*
dtype0?
dense_7/MatMulMatMuldense_6/Tanh:y:0%dense_7/MatMul/ReadVariableOp:value:0*
T0*(
_output_shapes
:???????????
dense_7/BiasAdd/ReadVariableOpReadVariableOp'dense_7_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
dense_7/BiasAddBiasAdddense_7/MatMul:product:0&dense_7/BiasAdd/ReadVariableOp:value:0*
T0*(
_output_shapes
:??????????a
dense_7/ReluReludense_7/BiasAdd:output:0*
T0*(
_output_shapes
:??????????d
"batch_normalization_1/LogicalAnd/xConst*
_output_shapes
: *
dtype0
*
value	B
 Zd
"batch_normalization_1/LogicalAnd/yConst*
_output_shapes
: *
value	B
 Z*
dtype0
?
 batch_normalization_1/LogicalAnd
LogicalAnd+batch_normalization_1/LogicalAnd/x:output:0+batch_normalization_1/LogicalAnd/y:output:0*
_output_shapes
: ~
4batch_normalization_1/moments/mean/reduction_indicesConst*
valueB: *
dtype0*
_output_shapes
:?
"batch_normalization_1/moments/meanMeandense_7/Relu:activations:0=batch_normalization_1/moments/mean/reduction_indices:output:0*
T0*
	keep_dims(*
_output_shapes
:	??
*batch_normalization_1/moments/StopGradientStopGradient+batch_normalization_1/moments/mean:output:0*
T0*
_output_shapes
:	??
/batch_normalization_1/moments/SquaredDifferenceSquaredDifferencedense_7/Relu:activations:03batch_normalization_1/moments/StopGradient:output:0*
T0*(
_output_shapes
:???????????
8batch_normalization_1/moments/variance/reduction_indicesConst*
valueB: *
dtype0*
_output_shapes
:?
&batch_normalization_1/moments/varianceMean3batch_normalization_1/moments/SquaredDifference:z:0Abatch_normalization_1/moments/variance/reduction_indices:output:0*
_output_shapes
:	?*
	keep_dims(*
T0?
%batch_normalization_1/moments/SqueezeSqueeze+batch_normalization_1/moments/mean:output:0*
squeeze_dims
 *
_output_shapes	
:?*
T0?
'batch_normalization_1/moments/Squeeze_1Squeeze/batch_normalization_1/moments/variance:output:0*
_output_shapes	
:?*
squeeze_dims
 *
T0?
9batch_normalization_1/AssignMovingAvg/Read/ReadVariableOpReadVariableOpBbatch_normalization_1_assignmovingavg_read_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
.batch_normalization_1/AssignMovingAvg/IdentityIdentityAbatch_normalization_1/AssignMovingAvg/Read/ReadVariableOp:value:0*
_output_shapes	
:?*
T0?
+batch_normalization_1/AssignMovingAvg/decayConst",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*L
_classB
@>loc:@batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp*
valueB
 *
?#<*
_output_shapes
: ?
4batch_normalization_1/AssignMovingAvg/ReadVariableOpReadVariableOpBbatch_normalization_1_assignmovingavg_read_readvariableop_resource:^batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
)batch_normalization_1/AssignMovingAvg/subSub<batch_normalization_1/AssignMovingAvg/ReadVariableOp:value:0.batch_normalization_1/moments/Squeeze:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*L
_classB
@>loc:@batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp*
T0?
)batch_normalization_1/AssignMovingAvg/mulMul-batch_normalization_1/AssignMovingAvg/sub:z:04batch_normalization_1/AssignMovingAvg/decay:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
T0*L
_classB
@>loc:@batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp?
9batch_normalization_1/AssignMovingAvg/AssignSubVariableOpAssignSubVariableOpBbatch_normalization_1_assignmovingavg_read_readvariableop_resource-batch_normalization_1/AssignMovingAvg/mul:z:05^batch_normalization_1/AssignMovingAvg/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*L
_classB
@>loc:@batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp*
_output_shapes
 *
dtype0?
;batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOpReadVariableOpDbatch_normalization_1_assignmovingavg_1_read_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
0batch_normalization_1/AssignMovingAvg_1/IdentityIdentityCbatch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp:value:0*
_output_shapes	
:?*
T0?
-batch_normalization_1/AssignMovingAvg_1/decayConst",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
: *
valueB
 *
?#<*
dtype0*N
_classD
B@loc:@batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp?
6batch_normalization_1/AssignMovingAvg_1/ReadVariableOpReadVariableOpDbatch_normalization_1_assignmovingavg_1_read_readvariableop_resource<^batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
+batch_normalization_1/AssignMovingAvg_1/subSub>batch_normalization_1/AssignMovingAvg_1/ReadVariableOp:value:00batch_normalization_1/moments/Squeeze_1:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
T0*N
_classD
B@loc:@batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp*
_output_shapes	
:??
+batch_normalization_1/AssignMovingAvg_1/mulMul/batch_normalization_1/AssignMovingAvg_1/sub:z:06batch_normalization_1/AssignMovingAvg_1/decay:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
T0*N
_classD
B@loc:@batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp?
;batch_normalization_1/AssignMovingAvg_1/AssignSubVariableOpAssignSubVariableOpDbatch_normalization_1_assignmovingavg_1_read_readvariableop_resource/batch_normalization_1/AssignMovingAvg_1/mul:z:07^batch_normalization_1/AssignMovingAvg_1/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*N
_classD
B@loc:@batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp*
_output_shapes
 *
dtype0j
%batch_normalization_1/batchnorm/add/yConst*
_output_shapes
: *
valueB
 *o?:*
dtype0?
#batch_normalization_1/batchnorm/addAddV20batch_normalization_1/moments/Squeeze_1:output:0.batch_normalization_1/batchnorm/add/y:output:0*
_output_shapes	
:?*
T0}
%batch_normalization_1/batchnorm/RsqrtRsqrt'batch_normalization_1/batchnorm/add:z:0*
_output_shapes	
:?*
T0?
2batch_normalization_1/batchnorm/mul/ReadVariableOpReadVariableOp;batch_normalization_1_batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
#batch_normalization_1/batchnorm/mulMul)batch_normalization_1/batchnorm/Rsqrt:y:0:batch_normalization_1/batchnorm/mul/ReadVariableOp:value:0*
_output_shapes	
:?*
T0?
%batch_normalization_1/batchnorm/mul_1Muldense_7/Relu:activations:0'batch_normalization_1/batchnorm/mul:z:0*(
_output_shapes
:??????????*
T0?
%batch_normalization_1/batchnorm/mul_2Mul.batch_normalization_1/moments/Squeeze:output:0'batch_normalization_1/batchnorm/mul:z:0*
_output_shapes	
:?*
T0?
.batch_normalization_1/batchnorm/ReadVariableOpReadVariableOp7batch_normalization_1_batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
#batch_normalization_1/batchnorm/subSub6batch_normalization_1/batchnorm/ReadVariableOp:value:0)batch_normalization_1/batchnorm/mul_2:z:0*
_output_shapes	
:?*
T0?
%batch_normalization_1/batchnorm/add_1AddV2)batch_normalization_1/batchnorm/mul_1:z:0'batch_normalization_1/batchnorm/sub:z:0*(
_output_shapes
:??????????*
T0[
dropout_1/dropout/rateConst*
_output_shapes
: *
dtype0*
valueB
 *   ?p
dropout_1/dropout/ShapeShape)batch_normalization_1/batchnorm/add_1:z:0*
_output_shapes
:*
T0i
$dropout_1/dropout/random_uniform/minConst*
valueB
 *    *
dtype0*
_output_shapes
: i
$dropout_1/dropout/random_uniform/maxConst*
valueB
 *  ??*
dtype0*
_output_shapes
: ?
.dropout_1/dropout/random_uniform/RandomUniformRandomUniform dropout_1/dropout/Shape:output:0*
dtype0*(
_output_shapes
:??????????*
T0?
$dropout_1/dropout/random_uniform/subSub-dropout_1/dropout/random_uniform/max:output:0-dropout_1/dropout/random_uniform/min:output:0*
T0*
_output_shapes
: ?
$dropout_1/dropout/random_uniform/mulMul7dropout_1/dropout/random_uniform/RandomUniform:output:0(dropout_1/dropout/random_uniform/sub:z:0*
T0*(
_output_shapes
:???????????
 dropout_1/dropout/random_uniformAdd(dropout_1/dropout/random_uniform/mul:z:0-dropout_1/dropout/random_uniform/min:output:0*
T0*(
_output_shapes
:??????????\
dropout_1/dropout/sub/xConst*
_output_shapes
: *
valueB
 *  ??*
dtype0?
dropout_1/dropout/subSub dropout_1/dropout/sub/x:output:0dropout_1/dropout/rate:output:0*
_output_shapes
: *
T0`
dropout_1/dropout/truediv/xConst*
_output_shapes
: *
valueB
 *  ??*
dtype0?
dropout_1/dropout/truedivRealDiv$dropout_1/dropout/truediv/x:output:0dropout_1/dropout/sub:z:0*
_output_shapes
: *
T0?
dropout_1/dropout/GreaterEqualGreaterEqual$dropout_1/dropout/random_uniform:z:0dropout_1/dropout/rate:output:0*
T0*(
_output_shapes
:???????????
dropout_1/dropout/mulMul)batch_normalization_1/batchnorm/add_1:z:0dropout_1/dropout/truediv:z:0*(
_output_shapes
:??????????*
T0?
dropout_1/dropout/CastCast"dropout_1/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*(
_output_shapes
:???????????
dropout_1/dropout/mul_1Muldropout_1/dropout/mul:z:0dropout_1/dropout/Cast:y:0*
T0*(
_output_shapes
:???????????
dense_8/MatMul/ReadVariableOpReadVariableOp&dense_8_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	?*
dtype0?
dense_8/MatMulMatMuldropout_1/dropout/mul_1:z:0%dense_8/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
dense_8/BiasAdd/ReadVariableOpReadVariableOp'dense_8_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:*
dtype0?
dense_8/BiasAddBiasAdddense_8/MatMul:product:0&dense_8/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????f
dense_8/SigmoidSigmoiddense_8/BiasAdd:output:0*'
_output_shapes
:?????????*
T0?
IdentityIdentitydense_8/Sigmoid:y:0:^batch_normalization_1/AssignMovingAvg/AssignSubVariableOp:^batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp5^batch_normalization_1/AssignMovingAvg/ReadVariableOp<^batch_normalization_1/AssignMovingAvg_1/AssignSubVariableOp<^batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp7^batch_normalization_1/AssignMovingAvg_1/ReadVariableOp/^batch_normalization_1/batchnorm/ReadVariableOp3^batch_normalization_1/batchnorm/mul/ReadVariableOp^dense_5/BiasAdd/ReadVariableOp^dense_5/MatMul/ReadVariableOp^dense_6/BiasAdd/ReadVariableOp^dense_6/MatMul/ReadVariableOp^dense_7/BiasAdd/ReadVariableOp^dense_7/MatMul/ReadVariableOp^dense_8/BiasAdd/ReadVariableOp^dense_8/MatMul/ReadVariableOp*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2@
dense_5/BiasAdd/ReadVariableOpdense_5/BiasAdd/ReadVariableOp2>
dense_5/MatMul/ReadVariableOpdense_5/MatMul/ReadVariableOp2z
;batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp;batch_normalization_1/AssignMovingAvg_1/Read/ReadVariableOp2v
9batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp9batch_normalization_1/AssignMovingAvg/Read/ReadVariableOp2@
dense_8/BiasAdd/ReadVariableOpdense_8/BiasAdd/ReadVariableOp2>
dense_6/MatMul/ReadVariableOpdense_6/MatMul/ReadVariableOp2l
4batch_normalization_1/AssignMovingAvg/ReadVariableOp4batch_normalization_1/AssignMovingAvg/ReadVariableOp2@
dense_6/BiasAdd/ReadVariableOpdense_6/BiasAdd/ReadVariableOp2h
2batch_normalization_1/batchnorm/mul/ReadVariableOp2batch_normalization_1/batchnorm/mul/ReadVariableOp2>
dense_7/MatMul/ReadVariableOpdense_7/MatMul/ReadVariableOp2z
;batch_normalization_1/AssignMovingAvg_1/AssignSubVariableOp;batch_normalization_1/AssignMovingAvg_1/AssignSubVariableOp2`
.batch_normalization_1/batchnorm/ReadVariableOp.batch_normalization_1/batchnorm/ReadVariableOp2p
6batch_normalization_1/AssignMovingAvg_1/ReadVariableOp6batch_normalization_1/AssignMovingAvg_1/ReadVariableOp2@
dense_7/BiasAdd/ReadVariableOpdense_7/BiasAdd/ReadVariableOp2>
dense_8/MatMul/ReadVariableOpdense_8/MatMul/ReadVariableOp2v
9batch_normalization_1/AssignMovingAvg/AssignSubVariableOp9batch_normalization_1/AssignMovingAvg/AssignSubVariableOp:
 : : :& "
 
_user_specified_nameinputs: : : : : : : : :	 
?	
?
C__inference_dense_5_layer_call_and_return_conditional_losses_249670

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	?p*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0?
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????P
ReluReluBiasAdd:output:0*'
_output_shapes
:?????????*
T0?
IdentityIdentityRelu:activations:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*/
_input_shapes
:??????????p::20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?
?
(__inference_dense_6_layer_call_fn_250216

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2*
Tout
2*L
fGRE
C__inference_dense_6_layer_call_and_return_conditional_losses_249698*'
_output_shapes
:?????????
**
config_proto

CPU

GPU 2J 8*
Tin
2*-
_gradient_op_typePartitionedCall-249704?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*'
_output_shapes
:?????????
*
T0"
identityIdentity:output:0*.
_input_shapes
:?????????::22
StatefulPartitionedCallStatefulPartitionedCall: :& "
 
_user_specified_nameinputs: 
?
?
6__inference_batch_normalization_1_layer_call_fn_250345

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4*
Tout
2*(
_output_shapes
:??????????*-
_gradient_op_typePartitionedCall-249613*Z
fURS
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249612**
config_proto

CPU

GPU 2J 8*
Tin	
2?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*(
_output_shapes
:??????????*
T0"
identityIdentity:output:0*7
_input_shapes&
$:??????????::::22
StatefulPartitionedCallStatefulPartitionedCall: :& "
 
_user_specified_nameinputs: : : 
?7
?
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249612

inputs0
,assignmovingavg_read_readvariableop_resource2
.assignmovingavg_1_read_readvariableop_resource)
%batchnorm_mul_readvariableop_resource%
!batchnorm_readvariableop_resource
identity??#AssignMovingAvg/AssignSubVariableOp?#AssignMovingAvg/Read/ReadVariableOp?AssignMovingAvg/ReadVariableOp?%AssignMovingAvg_1/AssignSubVariableOp?%AssignMovingAvg_1/Read/ReadVariableOp? AssignMovingAvg_1/ReadVariableOp?batchnorm/ReadVariableOp?batchnorm/mul/ReadVariableOpN
LogicalAnd/xConst*
_output_shapes
: *
value	B
 Z*
dtype0
N
LogicalAnd/yConst*
dtype0
*
_output_shapes
: *
value	B
 Z^

LogicalAnd
LogicalAndLogicalAnd/x:output:0LogicalAnd/y:output:0*
_output_shapes
: h
moments/mean/reduction_indicesConst*
_output_shapes
:*
valueB: *
dtype0?
moments/meanMeaninputs'moments/mean/reduction_indices:output:0*
	keep_dims(*
T0*
_output_shapes
:	?e
moments/StopGradientStopGradientmoments/mean:output:0*
_output_shapes
:	?*
T0?
moments/SquaredDifferenceSquaredDifferenceinputsmoments/StopGradient:output:0*
T0*(
_output_shapes
:??????????l
"moments/variance/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB: ?
moments/varianceMeanmoments/SquaredDifference:z:0+moments/variance/reduction_indices:output:0*
_output_shapes
:	?*
	keep_dims(*
T0n
moments/SqueezeSqueezemoments/mean:output:0*
squeeze_dims
 *
T0*
_output_shapes	
:?t
moments/Squeeze_1Squeezemoments/variance:output:0*
squeeze_dims
 *
T0*
_output_shapes	
:??
#AssignMovingAvg/Read/ReadVariableOpReadVariableOp,assignmovingavg_read_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?w
AssignMovingAvg/IdentityIdentity+AssignMovingAvg/Read/ReadVariableOp:value:0*
_output_shapes	
:?*
T0?
AssignMovingAvg/decayConst",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
: *
valueB
 *
?#<*
dtype0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp?
AssignMovingAvg/ReadVariableOpReadVariableOp,assignmovingavg_read_readvariableop_resource$^AssignMovingAvg/Read/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
AssignMovingAvg/subSub&AssignMovingAvg/ReadVariableOp:value:0moments/Squeeze:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
T0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp?
AssignMovingAvg/mulMulAssignMovingAvg/sub:z:0AssignMovingAvg/decay:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
T0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp?
#AssignMovingAvg/AssignSubVariableOpAssignSubVariableOp,assignmovingavg_read_readvariableop_resourceAssignMovingAvg/mul:z:0^AssignMovingAvg/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp*
_output_shapes
 *
dtype0?
%AssignMovingAvg_1/Read/ReadVariableOpReadVariableOp.assignmovingavg_1_read_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?{
AssignMovingAvg_1/IdentityIdentity-AssignMovingAvg_1/Read/ReadVariableOp:value:0*
T0*
_output_shapes	
:??
AssignMovingAvg_1/decayConst",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
: *
dtype0*
valueB
 *
?#<*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp?
 AssignMovingAvg_1/ReadVariableOpReadVariableOp.assignmovingavg_1_read_readvariableop_resource&^AssignMovingAvg_1/Read/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
AssignMovingAvg_1/subSub(AssignMovingAvg_1/ReadVariableOp:value:0moments/Squeeze_1:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp*
T0?
AssignMovingAvg_1/mulMulAssignMovingAvg_1/sub:z:0 AssignMovingAvg_1/decay:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp*
T0?
%AssignMovingAvg_1/AssignSubVariableOpAssignSubVariableOp.assignmovingavg_1_read_readvariableop_resourceAssignMovingAvg_1/mul:z:0!^AssignMovingAvg_1/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp*
_output_shapes
 *
dtype0T
batchnorm/add/yConst*
valueB
 *o?:*
_output_shapes
: *
dtype0r
batchnorm/addAddV2moments/Squeeze_1:output:0batchnorm/add/y:output:0*
_output_shapes	
:?*
T0Q
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes	
:??
batchnorm/mul/ReadVariableOpReadVariableOp%batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?u
batchnorm/mulMulbatchnorm/Rsqrt:y:0$batchnorm/mul/ReadVariableOp:value:0*
_output_shapes	
:?*
T0d
batchnorm/mul_1Mulinputsbatchnorm/mul:z:0*
T0*(
_output_shapes
:??????????i
batchnorm/mul_2Mulmoments/Squeeze:output:0batchnorm/mul:z:0*
_output_shapes	
:?*
T0?
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0q
batchnorm/subSub batchnorm/ReadVariableOp:value:0batchnorm/mul_2:z:0*
T0*
_output_shapes	
:?s
batchnorm/add_1AddV2batchnorm/mul_1:z:0batchnorm/sub:z:0*(
_output_shapes
:??????????*
T0?
IdentityIdentitybatchnorm/add_1:z:0$^AssignMovingAvg/AssignSubVariableOp$^AssignMovingAvg/Read/ReadVariableOp^AssignMovingAvg/ReadVariableOp&^AssignMovingAvg_1/AssignSubVariableOp&^AssignMovingAvg_1/Read/ReadVariableOp!^AssignMovingAvg_1/ReadVariableOp^batchnorm/ReadVariableOp^batchnorm/mul/ReadVariableOp*(
_output_shapes
:??????????*
T0"
identityIdentity:output:0*7
_input_shapes&
$:??????????::::2N
%AssignMovingAvg_1/Read/ReadVariableOp%AssignMovingAvg_1/Read/ReadVariableOp24
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp2J
#AssignMovingAvg/AssignSubVariableOp#AssignMovingAvg/AssignSubVariableOp2D
 AssignMovingAvg_1/ReadVariableOp AssignMovingAvg_1/ReadVariableOp2N
%AssignMovingAvg_1/AssignSubVariableOp%AssignMovingAvg_1/AssignSubVariableOp2<
batchnorm/mul/ReadVariableOpbatchnorm/mul/ReadVariableOp2J
#AssignMovingAvg/Read/ReadVariableOp#AssignMovingAvg/Read/ReadVariableOp2@
AssignMovingAvg/ReadVariableOpAssignMovingAvg/ReadVariableOp:& "
 
_user_specified_nameinputs: : : : 
?
d
E__inference_dropout_1_layer_call_and_return_conditional_losses_250374

inputs
identity?Q
dropout/rateConst*
dtype0*
valueB
 *   ?*
_output_shapes
: C
dropout/ShapeShapeinputs*
_output_shapes
:*
T0_
dropout/random_uniform/minConst*
_output_shapes
: *
valueB
 *    *
dtype0_
dropout/random_uniform/maxConst*
_output_shapes
: *
valueB
 *  ??*
dtype0?
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*(
_output_shapes
:??????????*
dtype0?
dropout/random_uniform/subSub#dropout/random_uniform/max:output:0#dropout/random_uniform/min:output:0*
_output_shapes
: *
T0?
dropout/random_uniform/mulMul-dropout/random_uniform/RandomUniform:output:0dropout/random_uniform/sub:z:0*
T0*(
_output_shapes
:???????????
dropout/random_uniformAdddropout/random_uniform/mul:z:0#dropout/random_uniform/min:output:0*
T0*(
_output_shapes
:??????????R
dropout/sub/xConst*
_output_shapes
: *
valueB
 *  ??*
dtype0b
dropout/subSubdropout/sub/x:output:0dropout/rate:output:0*
T0*
_output_shapes
: V
dropout/truediv/xConst*
_output_shapes
: *
valueB
 *  ??*
dtype0h
dropout/truedivRealDivdropout/truediv/x:output:0dropout/sub:z:0*
T0*
_output_shapes
: ?
dropout/GreaterEqualGreaterEqualdropout/random_uniform:z:0dropout/rate:output:0*
T0*(
_output_shapes
:??????????b
dropout/mulMulinputsdropout/truediv:z:0*(
_output_shapes
:??????????*
T0p
dropout/CastCastdropout/GreaterEqual:z:0*

SrcT0
*

DstT0*(
_output_shapes
:??????????j
dropout/mul_1Muldropout/mul:z:0dropout/Cast:y:0*
T0*(
_output_shapes
:??????????Z
IdentityIdentitydropout/mul_1:z:0*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*'
_input_shapes
:??????????:& "
 
_user_specified_nameinputs
?	
?
C__inference_dense_5_layer_call_and_return_conditional_losses_250191

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	?p*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0P
ReluReluBiasAdd:output:0*
T0*'
_output_shapes
:??????????
IdentityIdentityRelu:activations:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*/
_input_shapes
:??????????p::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?P
?
__inference__traced_save_250549
file_prefix-
)savev2_dense_5_kernel_read_readvariableop+
'savev2_dense_5_bias_read_readvariableop-
)savev2_dense_6_kernel_read_readvariableop+
'savev2_dense_6_bias_read_readvariableop-
)savev2_dense_7_kernel_read_readvariableop+
'savev2_dense_7_bias_read_readvariableop:
6savev2_batch_normalization_1_gamma_read_readvariableop9
5savev2_batch_normalization_1_beta_read_readvariableop@
<savev2_batch_normalization_1_moving_mean_read_readvariableopD
@savev2_batch_normalization_1_moving_variance_read_readvariableop-
)savev2_dense_8_kernel_read_readvariableop+
'savev2_dense_8_bias_read_readvariableop3
/savev2_training_1_adam_iter_read_readvariableop	5
1savev2_training_1_adam_beta_1_read_readvariableop5
1savev2_training_1_adam_beta_2_read_readvariableop4
0savev2_training_1_adam_decay_read_readvariableop<
8savev2_training_1_adam_learning_rate_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop?
;savev2_training_1_adam_dense_5_kernel_m_read_readvariableop=
9savev2_training_1_adam_dense_5_bias_m_read_readvariableop?
;savev2_training_1_adam_dense_6_kernel_m_read_readvariableop=
9savev2_training_1_adam_dense_6_bias_m_read_readvariableop?
;savev2_training_1_adam_dense_7_kernel_m_read_readvariableop=
9savev2_training_1_adam_dense_7_bias_m_read_readvariableopL
Hsavev2_training_1_adam_batch_normalization_1_gamma_m_read_readvariableopK
Gsavev2_training_1_adam_batch_normalization_1_beta_m_read_readvariableop?
;savev2_training_1_adam_dense_8_kernel_m_read_readvariableop=
9savev2_training_1_adam_dense_8_bias_m_read_readvariableop?
;savev2_training_1_adam_dense_5_kernel_v_read_readvariableop=
9savev2_training_1_adam_dense_5_bias_v_read_readvariableop?
;savev2_training_1_adam_dense_6_kernel_v_read_readvariableop=
9savev2_training_1_adam_dense_6_bias_v_read_readvariableop?
;savev2_training_1_adam_dense_7_kernel_v_read_readvariableop=
9savev2_training_1_adam_dense_7_bias_v_read_readvariableopL
Hsavev2_training_1_adam_batch_normalization_1_gamma_v_read_readvariableopK
Gsavev2_training_1_adam_batch_normalization_1_beta_v_read_readvariableop?
;savev2_training_1_adam_dense_8_kernel_v_read_readvariableop=
9savev2_training_1_adam_dense_8_bias_v_read_readvariableop
savev2_1_const

identity_1??MergeV2Checkpoints?SaveV2?SaveV2_1?
StringJoin/inputs_1Const"/device:CPU:0*<
value3B1 B+_temp_9955a36cbdea4d5194624b95aa36c37a/part*
dtype0*
_output_shapes
: s

StringJoin
StringJoinfile_prefixStringJoin/inputs_1:output:0"/device:CPU:0*
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : ?
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: ?
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:'*
dtype0*?
value?B?'B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB5layer_with_weights-3/gamma/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-3/beta/.ATTRIBUTES/VARIABLE_VALUEB;layer_with_weights-3/moving_mean/.ATTRIBUTES/VARIABLE_VALUEB?layer_with_weights-3/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBQlayer_with_weights-3/gamma/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/beta/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBQlayer_with_weights-3/gamma/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/beta/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE?
SaveV2/shape_and_slicesConst"/device:CPU:0*a
valueXBV'B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B *
_output_shapes
:'*
dtype0?
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0)savev2_dense_5_kernel_read_readvariableop'savev2_dense_5_bias_read_readvariableop)savev2_dense_6_kernel_read_readvariableop'savev2_dense_6_bias_read_readvariableop)savev2_dense_7_kernel_read_readvariableop'savev2_dense_7_bias_read_readvariableop6savev2_batch_normalization_1_gamma_read_readvariableop5savev2_batch_normalization_1_beta_read_readvariableop<savev2_batch_normalization_1_moving_mean_read_readvariableop@savev2_batch_normalization_1_moving_variance_read_readvariableop)savev2_dense_8_kernel_read_readvariableop'savev2_dense_8_bias_read_readvariableop/savev2_training_1_adam_iter_read_readvariableop1savev2_training_1_adam_beta_1_read_readvariableop1savev2_training_1_adam_beta_2_read_readvariableop0savev2_training_1_adam_decay_read_readvariableop8savev2_training_1_adam_learning_rate_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop;savev2_training_1_adam_dense_5_kernel_m_read_readvariableop9savev2_training_1_adam_dense_5_bias_m_read_readvariableop;savev2_training_1_adam_dense_6_kernel_m_read_readvariableop9savev2_training_1_adam_dense_6_bias_m_read_readvariableop;savev2_training_1_adam_dense_7_kernel_m_read_readvariableop9savev2_training_1_adam_dense_7_bias_m_read_readvariableopHsavev2_training_1_adam_batch_normalization_1_gamma_m_read_readvariableopGsavev2_training_1_adam_batch_normalization_1_beta_m_read_readvariableop;savev2_training_1_adam_dense_8_kernel_m_read_readvariableop9savev2_training_1_adam_dense_8_bias_m_read_readvariableop;savev2_training_1_adam_dense_5_kernel_v_read_readvariableop9savev2_training_1_adam_dense_5_bias_v_read_readvariableop;savev2_training_1_adam_dense_6_kernel_v_read_readvariableop9savev2_training_1_adam_dense_6_bias_v_read_readvariableop;savev2_training_1_adam_dense_7_kernel_v_read_readvariableop9savev2_training_1_adam_dense_7_bias_v_read_readvariableopHsavev2_training_1_adam_batch_normalization_1_gamma_v_read_readvariableopGsavev2_training_1_adam_batch_normalization_1_beta_v_read_readvariableop;savev2_training_1_adam_dense_8_kernel_v_read_readvariableop9savev2_training_1_adam_dense_8_bias_v_read_readvariableop"/device:CPU:0*
_output_shapes
 *5
dtypes+
)2'	h
ShardedFilename_1/shardConst"/device:CPU:0*
_output_shapes
: *
value	B :*
dtype0?
ShardedFilename_1ShardedFilenameStringJoin:output:0 ShardedFilename_1/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: ?
SaveV2_1/tensor_namesConst"/device:CPU:0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPH*
dtype0*
_output_shapes
:q
SaveV2_1/shape_and_slicesConst"/device:CPU:0*
dtype0*
valueB
B *
_output_shapes
:?
SaveV2_1SaveV2ShardedFilename_1:filename:0SaveV2_1/tensor_names:output:0"SaveV2_1/shape_and_slices:output:0savev2_1_const^SaveV2"/device:CPU:0*
_output_shapes
 *
dtypes
2?
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0ShardedFilename_1:filename:0^SaveV2	^SaveV2_1"/device:CPU:0*
T0*
N*
_output_shapes
:?
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix	^SaveV2_1"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
_output_shapes
: *
T0s

Identity_1IdentityIdentity:output:0^MergeV2Checkpoints^SaveV2	^SaveV2_1*
T0*
_output_shapes
: "!

identity_1Identity_1:output:0*?
_input_shapes?
?: :	?p::
:
:	
?:?:?:?:?:?:	?:: : : : : : : :	?p::
:
:	
?:?:?:?:	?::	?p::
:
:	
?:?:?:?:	?:: 2
SaveV2_1SaveV2_12(
MergeV2CheckpointsMergeV2Checkpoints2
SaveV2SaveV2: : : : : : : : : : : : : : : : : : : : :  :! :" :# :$ :% :& :' :( :+ '
%
_user_specified_namefile_prefix: : : : : : : : :	 :
 : 
?	
?
C__inference_dense_7_layer_call_and_return_conditional_losses_249726

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	
?*
dtype0j
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*(
_output_shapes
:???????????
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?w
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*(
_output_shapes
:??????????*
T0Q
ReluReluBiasAdd:output:0*
T0*(
_output_shapes
:???????????
IdentityIdentityRelu:activations:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*.
_input_shapes
:?????????
::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?	
?
C__inference_dense_6_layer_call_and_return_conditional_losses_249698

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes

:
*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????
?
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:
*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????
P
TanhTanhBiasAdd:output:0*'
_output_shapes
:?????????
*
T0?
IdentityIdentityTanh:y:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*
T0*'
_output_shapes
:?????????
"
identityIdentity:output:0*.
_input_shapes
:?????????::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?
?
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_250336

inputs%
!batchnorm_readvariableop_resource)
%batchnorm_mul_readvariableop_resource'
#batchnorm_readvariableop_1_resource'
#batchnorm_readvariableop_2_resource
identity??batchnorm/ReadVariableOp?batchnorm/ReadVariableOp_1?batchnorm/ReadVariableOp_2?batchnorm/mul/ReadVariableOpN
LogicalAnd/xConst*
dtype0
*
_output_shapes
: *
value	B
 Z N
LogicalAnd/yConst*
_output_shapes
: *
value	B
 Z*
dtype0
^

LogicalAnd
LogicalAndLogicalAnd/x:output:0LogicalAnd/y:output:0*
_output_shapes
: ?
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?T
batchnorm/add/yConst*
dtype0*
_output_shapes
: *
valueB
 *o?:x
batchnorm/addAddV2 batchnorm/ReadVariableOp:value:0batchnorm/add/y:output:0*
_output_shapes	
:?*
T0Q
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes	
:??
batchnorm/mul/ReadVariableOpReadVariableOp%batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0u
batchnorm/mulMulbatchnorm/Rsqrt:y:0$batchnorm/mul/ReadVariableOp:value:0*
_output_shapes	
:?*
T0d
batchnorm/mul_1Mulinputsbatchnorm/mul:z:0*(
_output_shapes
:??????????*
T0?
batchnorm/ReadVariableOp_1ReadVariableOp#batchnorm_readvariableop_1_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?s
batchnorm/mul_2Mul"batchnorm/ReadVariableOp_1:value:0batchnorm/mul:z:0*
_output_shapes	
:?*
T0?
batchnorm/ReadVariableOp_2ReadVariableOp#batchnorm_readvariableop_2_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0s
batchnorm/subSub"batchnorm/ReadVariableOp_2:value:0batchnorm/mul_2:z:0*
T0*
_output_shapes	
:?s
batchnorm/add_1AddV2batchnorm/mul_1:z:0batchnorm/sub:z:0*
T0*(
_output_shapes
:???????????
IdentityIdentitybatchnorm/add_1:z:0^batchnorm/ReadVariableOp^batchnorm/ReadVariableOp_1^batchnorm/ReadVariableOp_2^batchnorm/mul/ReadVariableOp*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*7
_input_shapes&
$:??????????::::28
batchnorm/ReadVariableOp_1batchnorm/ReadVariableOp_128
batchnorm/ReadVariableOp_2batchnorm/ReadVariableOp_224
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp2<
batchnorm/mul/ReadVariableOpbatchnorm/mul/ReadVariableOp:& "
 
_user_specified_nameinputs: : : : 
?B
?	
H__inference_sequential_8_layer_call_and_return_conditional_losses_250146

inputs*
&dense_5_matmul_readvariableop_resource+
'dense_5_biasadd_readvariableop_resource*
&dense_6_matmul_readvariableop_resource+
'dense_6_biasadd_readvariableop_resource*
&dense_7_matmul_readvariableop_resource+
'dense_7_biasadd_readvariableop_resource;
7batch_normalization_1_batchnorm_readvariableop_resource?
;batch_normalization_1_batchnorm_mul_readvariableop_resource=
9batch_normalization_1_batchnorm_readvariableop_1_resource=
9batch_normalization_1_batchnorm_readvariableop_2_resource*
&dense_8_matmul_readvariableop_resource+
'dense_8_biasadd_readvariableop_resource
identity??.batch_normalization_1/batchnorm/ReadVariableOp?0batch_normalization_1/batchnorm/ReadVariableOp_1?0batch_normalization_1/batchnorm/ReadVariableOp_2?2batch_normalization_1/batchnorm/mul/ReadVariableOp?dense_5/BiasAdd/ReadVariableOp?dense_5/MatMul/ReadVariableOp?dense_6/BiasAdd/ReadVariableOp?dense_6/MatMul/ReadVariableOp?dense_7/BiasAdd/ReadVariableOp?dense_7/MatMul/ReadVariableOp?dense_8/BiasAdd/ReadVariableOp?dense_8/MatMul/ReadVariableOp?
dense_5/MatMul/ReadVariableOpReadVariableOp&dense_5_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	?py
dense_5/MatMulMatMulinputs%dense_5/MatMul/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0?
dense_5/BiasAdd/ReadVariableOpReadVariableOp'dense_5_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:*
dtype0?
dense_5/BiasAddBiasAdddense_5/MatMul:product:0&dense_5/BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0`
dense_5/ReluReludense_5/BiasAdd:output:0*'
_output_shapes
:?????????*
T0?
dense_6/MatMul/ReadVariableOpReadVariableOp&dense_6_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes

:
?
dense_6/MatMulMatMuldense_5/Relu:activations:0%dense_6/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????
?
dense_6/BiasAdd/ReadVariableOpReadVariableOp'dense_6_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:
*
dtype0?
dense_6/BiasAddBiasAdddense_6/MatMul:product:0&dense_6/BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????
*
T0`
dense_6/TanhTanhdense_6/BiasAdd:output:0*'
_output_shapes
:?????????
*
T0?
dense_7/MatMul/ReadVariableOpReadVariableOp&dense_7_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	
??
dense_7/MatMulMatMuldense_6/Tanh:y:0%dense_7/MatMul/ReadVariableOp:value:0*(
_output_shapes
:??????????*
T0?
dense_7/BiasAdd/ReadVariableOpReadVariableOp'dense_7_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
dense_7/BiasAddBiasAdddense_7/MatMul:product:0&dense_7/BiasAdd/ReadVariableOp:value:0*(
_output_shapes
:??????????*
T0a
dense_7/ReluReludense_7/BiasAdd:output:0*(
_output_shapes
:??????????*
T0d
"batch_normalization_1/LogicalAnd/xConst*
value	B
 Z *
_output_shapes
: *
dtype0
d
"batch_normalization_1/LogicalAnd/yConst*
dtype0
*
_output_shapes
: *
value	B
 Z?
 batch_normalization_1/LogicalAnd
LogicalAnd+batch_normalization_1/LogicalAnd/x:output:0+batch_normalization_1/LogicalAnd/y:output:0*
_output_shapes
: ?
.batch_normalization_1/batchnorm/ReadVariableOpReadVariableOp7batch_normalization_1_batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0j
%batch_normalization_1/batchnorm/add/yConst*
dtype0*
valueB
 *o?:*
_output_shapes
: ?
#batch_normalization_1/batchnorm/addAddV26batch_normalization_1/batchnorm/ReadVariableOp:value:0.batch_normalization_1/batchnorm/add/y:output:0*
T0*
_output_shapes	
:?}
%batch_normalization_1/batchnorm/RsqrtRsqrt'batch_normalization_1/batchnorm/add:z:0*
_output_shapes	
:?*
T0?
2batch_normalization_1/batchnorm/mul/ReadVariableOpReadVariableOp;batch_normalization_1_batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
#batch_normalization_1/batchnorm/mulMul)batch_normalization_1/batchnorm/Rsqrt:y:0:batch_normalization_1/batchnorm/mul/ReadVariableOp:value:0*
T0*
_output_shapes	
:??
%batch_normalization_1/batchnorm/mul_1Muldense_7/Relu:activations:0'batch_normalization_1/batchnorm/mul:z:0*(
_output_shapes
:??????????*
T0?
0batch_normalization_1/batchnorm/ReadVariableOp_1ReadVariableOp9batch_normalization_1_batchnorm_readvariableop_1_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
%batch_normalization_1/batchnorm/mul_2Mul8batch_normalization_1/batchnorm/ReadVariableOp_1:value:0'batch_normalization_1/batchnorm/mul:z:0*
_output_shapes	
:?*
T0?
0batch_normalization_1/batchnorm/ReadVariableOp_2ReadVariableOp9batch_normalization_1_batchnorm_readvariableop_2_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
#batch_normalization_1/batchnorm/subSub8batch_normalization_1/batchnorm/ReadVariableOp_2:value:0)batch_normalization_1/batchnorm/mul_2:z:0*
_output_shapes	
:?*
T0?
%batch_normalization_1/batchnorm/add_1AddV2)batch_normalization_1/batchnorm/mul_1:z:0'batch_normalization_1/batchnorm/sub:z:0*
T0*(
_output_shapes
:??????????|
dropout_1/IdentityIdentity)batch_normalization_1/batchnorm/add_1:z:0*(
_output_shapes
:??????????*
T0?
dense_8/MatMul/ReadVariableOpReadVariableOp&dense_8_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	??
dense_8/MatMulMatMuldropout_1/Identity:output:0%dense_8/MatMul/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0?
dense_8/BiasAdd/ReadVariableOpReadVariableOp'dense_8_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:?
dense_8/BiasAddBiasAdddense_8/MatMul:product:0&dense_8/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????f
dense_8/SigmoidSigmoiddense_8/BiasAdd:output:0*'
_output_shapes
:?????????*
T0?
IdentityIdentitydense_8/Sigmoid:y:0/^batch_normalization_1/batchnorm/ReadVariableOp1^batch_normalization_1/batchnorm/ReadVariableOp_11^batch_normalization_1/batchnorm/ReadVariableOp_23^batch_normalization_1/batchnorm/mul/ReadVariableOp^dense_5/BiasAdd/ReadVariableOp^dense_5/MatMul/ReadVariableOp^dense_6/BiasAdd/ReadVariableOp^dense_6/MatMul/ReadVariableOp^dense_7/BiasAdd/ReadVariableOp^dense_7/MatMul/ReadVariableOp^dense_8/BiasAdd/ReadVariableOp^dense_8/MatMul/ReadVariableOp*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2>
dense_5/MatMul/ReadVariableOpdense_5/MatMul/ReadVariableOp2@
dense_5/BiasAdd/ReadVariableOpdense_5/BiasAdd/ReadVariableOp2@
dense_8/BiasAdd/ReadVariableOpdense_8/BiasAdd/ReadVariableOp2>
dense_6/MatMul/ReadVariableOpdense_6/MatMul/ReadVariableOp2@
dense_6/BiasAdd/ReadVariableOpdense_6/BiasAdd/ReadVariableOp2h
2batch_normalization_1/batchnorm/mul/ReadVariableOp2batch_normalization_1/batchnorm/mul/ReadVariableOp2>
dense_7/MatMul/ReadVariableOpdense_7/MatMul/ReadVariableOp2`
.batch_normalization_1/batchnorm/ReadVariableOp.batch_normalization_1/batchnorm/ReadVariableOp2@
dense_7/BiasAdd/ReadVariableOpdense_7/BiasAdd/ReadVariableOp2d
0batch_normalization_1/batchnorm/ReadVariableOp_10batch_normalization_1/batchnorm/ReadVariableOp_12>
dense_8/MatMul/ReadVariableOpdense_8/MatMul/ReadVariableOp2d
0batch_normalization_1/batchnorm/ReadVariableOp_20batch_normalization_1/batchnorm/ReadVariableOp_2: : : : : : : :	 :
 : : :& "
 
_user_specified_nameinputs: 
?
F
*__inference_dropout_1_layer_call_fn_250389

inputs
identity?
PartitionedCallPartitionedCallinputs**
config_proto

CPU

GPU 2J 8*
Tout
2*-
_gradient_op_typePartitionedCall-249805*(
_output_shapes
:??????????*N
fIRG
E__inference_dropout_1_layer_call_and_return_conditional_losses_249793*
Tin
2a
IdentityIdentityPartitionedCall:output:0*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*'
_input_shapes
:??????????:& "
 
_user_specified_nameinputs
?7
?
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_250313

inputs0
,assignmovingavg_read_readvariableop_resource2
.assignmovingavg_1_read_readvariableop_resource)
%batchnorm_mul_readvariableop_resource%
!batchnorm_readvariableop_resource
identity??#AssignMovingAvg/AssignSubVariableOp?#AssignMovingAvg/Read/ReadVariableOp?AssignMovingAvg/ReadVariableOp?%AssignMovingAvg_1/AssignSubVariableOp?%AssignMovingAvg_1/Read/ReadVariableOp? AssignMovingAvg_1/ReadVariableOp?batchnorm/ReadVariableOp?batchnorm/mul/ReadVariableOpN
LogicalAnd/xConst*
_output_shapes
: *
value	B
 Z*
dtype0
N
LogicalAnd/yConst*
dtype0
*
_output_shapes
: *
value	B
 Z^

LogicalAnd
LogicalAndLogicalAnd/x:output:0LogicalAnd/y:output:0*
_output_shapes
: h
moments/mean/reduction_indicesConst*
valueB: *
dtype0*
_output_shapes
:?
moments/meanMeaninputs'moments/mean/reduction_indices:output:0*
	keep_dims(*
T0*
_output_shapes
:	?e
moments/StopGradientStopGradientmoments/mean:output:0*
T0*
_output_shapes
:	??
moments/SquaredDifferenceSquaredDifferenceinputsmoments/StopGradient:output:0*(
_output_shapes
:??????????*
T0l
"moments/variance/reduction_indicesConst*
valueB: *
dtype0*
_output_shapes
:?
moments/varianceMeanmoments/SquaredDifference:z:0+moments/variance/reduction_indices:output:0*
T0*
_output_shapes
:	?*
	keep_dims(n
moments/SqueezeSqueezemoments/mean:output:0*
_output_shapes	
:?*
T0*
squeeze_dims
 t
moments/Squeeze_1Squeezemoments/variance:output:0*
T0*
squeeze_dims
 *
_output_shapes	
:??
#AssignMovingAvg/Read/ReadVariableOpReadVariableOp,assignmovingavg_read_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?w
AssignMovingAvg/IdentityIdentity+AssignMovingAvg/Read/ReadVariableOp:value:0*
T0*
_output_shapes	
:??
AssignMovingAvg/decayConst",/job:localhost/replica:0/task:0/device:CPU:0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp*
valueB
 *
?#<*
dtype0*
_output_shapes
: ?
AssignMovingAvg/ReadVariableOpReadVariableOp,assignmovingavg_read_readvariableop_resource$^AssignMovingAvg/Read/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
AssignMovingAvg/subSub&AssignMovingAvg/ReadVariableOp:value:0moments/Squeeze:output:0",/job:localhost/replica:0/task:0/device:CPU:0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp*
_output_shapes	
:?*
T0?
AssignMovingAvg/mulMulAssignMovingAvg/sub:z:0AssignMovingAvg/decay:output:0",/job:localhost/replica:0/task:0/device:CPU:0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp*
_output_shapes	
:?*
T0?
#AssignMovingAvg/AssignSubVariableOpAssignSubVariableOp,assignmovingavg_read_readvariableop_resourceAssignMovingAvg/mul:z:0^AssignMovingAvg/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*6
_class,
*(loc:@AssignMovingAvg/Read/ReadVariableOp*
dtype0*
_output_shapes
 ?
%AssignMovingAvg_1/Read/ReadVariableOpReadVariableOp.assignmovingavg_1_read_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0{
AssignMovingAvg_1/IdentityIdentity-AssignMovingAvg_1/Read/ReadVariableOp:value:0*
_output_shapes	
:?*
T0?
AssignMovingAvg_1/decayConst",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
: *
dtype0*
valueB
 *
?#<*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp?
 AssignMovingAvg_1/ReadVariableOpReadVariableOp.assignmovingavg_1_read_readvariableop_resource&^AssignMovingAvg_1/Read/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
AssignMovingAvg_1/subSub(AssignMovingAvg_1/ReadVariableOp:value:0moments/Squeeze_1:output:0",/job:localhost/replica:0/task:0/device:CPU:0*
T0*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp*
_output_shapes	
:??
AssignMovingAvg_1/mulMulAssignMovingAvg_1/sub:z:0 AssignMovingAvg_1/decay:output:0",/job:localhost/replica:0/task:0/device:CPU:0*8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp*
T0*
_output_shapes	
:??
%AssignMovingAvg_1/AssignSubVariableOpAssignSubVariableOp.assignmovingavg_1_read_readvariableop_resourceAssignMovingAvg_1/mul:z:0!^AssignMovingAvg_1/ReadVariableOp",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
 *8
_class.
,*loc:@AssignMovingAvg_1/Read/ReadVariableOp*
dtype0T
batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *o?:r
batchnorm/addAddV2moments/Squeeze_1:output:0batchnorm/add/y:output:0*
T0*
_output_shapes	
:?Q
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes	
:??
batchnorm/mul/ReadVariableOpReadVariableOp%batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?u
batchnorm/mulMulbatchnorm/Rsqrt:y:0$batchnorm/mul/ReadVariableOp:value:0*
T0*
_output_shapes	
:?d
batchnorm/mul_1Mulinputsbatchnorm/mul:z:0*
T0*(
_output_shapes
:??????????i
batchnorm/mul_2Mulmoments/Squeeze:output:0batchnorm/mul:z:0*
_output_shapes	
:?*
T0?
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0q
batchnorm/subSub batchnorm/ReadVariableOp:value:0batchnorm/mul_2:z:0*
_output_shapes	
:?*
T0s
batchnorm/add_1AddV2batchnorm/mul_1:z:0batchnorm/sub:z:0*
T0*(
_output_shapes
:???????????
IdentityIdentitybatchnorm/add_1:z:0$^AssignMovingAvg/AssignSubVariableOp$^AssignMovingAvg/Read/ReadVariableOp^AssignMovingAvg/ReadVariableOp&^AssignMovingAvg_1/AssignSubVariableOp&^AssignMovingAvg_1/Read/ReadVariableOp!^AssignMovingAvg_1/ReadVariableOp^batchnorm/ReadVariableOp^batchnorm/mul/ReadVariableOp*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*7
_input_shapes&
$:??????????::::2J
#AssignMovingAvg/Read/ReadVariableOp#AssignMovingAvg/Read/ReadVariableOp2@
AssignMovingAvg/ReadVariableOpAssignMovingAvg/ReadVariableOp2J
#AssignMovingAvg/AssignSubVariableOp#AssignMovingAvg/AssignSubVariableOp24
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp2N
%AssignMovingAvg_1/Read/ReadVariableOp%AssignMovingAvg_1/Read/ReadVariableOp2D
 AssignMovingAvg_1/ReadVariableOp AssignMovingAvg_1/ReadVariableOp2N
%AssignMovingAvg_1/AssignSubVariableOp%AssignMovingAvg_1/AssignSubVariableOp2<
batchnorm/mul/ReadVariableOpbatchnorm/mul/ReadVariableOp:& "
 
_user_specified_nameinputs: : : : 
?	
?
C__inference_dense_8_layer_call_and_return_conditional_losses_249821

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	?i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:??????????
IdentityIdentitySigmoid:y:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*/
_input_shapes
:??????????::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?
?
-__inference_sequential_8_layer_call_fn_250163

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4"
statefulpartitionedcall_args_5"
statefulpartitionedcall_args_6"
statefulpartitionedcall_args_7"
statefulpartitionedcall_args_8"
statefulpartitionedcall_args_9#
statefulpartitionedcall_args_10#
statefulpartitionedcall_args_11#
statefulpartitionedcall_args_12
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4statefulpartitionedcall_args_5statefulpartitionedcall_args_6statefulpartitionedcall_args_7statefulpartitionedcall_args_8statefulpartitionedcall_args_9statefulpartitionedcall_args_10statefulpartitionedcall_args_11statefulpartitionedcall_args_12*Q
fLRJ
H__inference_sequential_8_layer_call_and_return_conditional_losses_249888*
Tout
2**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249889*
Tin
2*'
_output_shapes
:??????????
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs: : : : : : : : :	 :
 : : 
?
?
(__inference_dense_7_layer_call_fn_250234

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2*
Tout
2*-
_gradient_op_typePartitionedCall-249732*L
fGRE
C__inference_dense_7_layer_call_and_return_conditional_losses_249726*
Tin
2*(
_output_shapes
:??????????**
config_proto

CPU

GPU 2J 8?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*(
_output_shapes
:??????????*
T0"
identityIdentity:output:0*.
_input_shapes
:?????????
::22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs: : 
?	
?
C__inference_dense_7_layer_call_and_return_conditional_losses_250227

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	
?j
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*(
_output_shapes
:???????????
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0w
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*(
_output_shapes
:??????????Q
ReluReluBiasAdd:output:0*(
_output_shapes
:??????????*
T0?
IdentityIdentityRelu:activations:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*(
_output_shapes
:??????????*
T0"
identityIdentity:output:0*.
_input_shapes
:?????????
::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?
?
(__inference_dense_5_layer_call_fn_250198

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2*
Tout
2**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249676*'
_output_shapes
:?????????*L
fGRE
C__inference_dense_5_layer_call_and_return_conditional_losses_249670*
Tin
2?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*/
_input_shapes
:??????????p::22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs: : 
?
?
6__inference_batch_normalization_1_layer_call_fn_250354

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4*Z
fURS
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249647*(
_output_shapes
:??????????*
Tin	
2*-
_gradient_op_typePartitionedCall-249648*
Tout
2**
config_proto

CPU

GPU 2J 8?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*7
_input_shapes&
$:??????????::::22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs: : : : 
?	
?
C__inference_dense_8_layer_call_and_return_conditional_losses_250400

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	?i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????V
SigmoidSigmoidBiasAdd:output:0*'
_output_shapes
:?????????*
T0?
IdentityIdentitySigmoid:y:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*/
_input_shapes
:??????????::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?
?
-__inference_sequential_8_layer_call_fn_249904
dense_5_input"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4"
statefulpartitionedcall_args_5"
statefulpartitionedcall_args_6"
statefulpartitionedcall_args_7"
statefulpartitionedcall_args_8"
statefulpartitionedcall_args_9#
statefulpartitionedcall_args_10#
statefulpartitionedcall_args_11#
statefulpartitionedcall_args_12
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCalldense_5_inputstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4statefulpartitionedcall_args_5statefulpartitionedcall_args_6statefulpartitionedcall_args_7statefulpartitionedcall_args_8statefulpartitionedcall_args_9statefulpartitionedcall_args_10statefulpartitionedcall_args_11statefulpartitionedcall_args_12*
Tout
2**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249889*'
_output_shapes
:?????????*
Tin
2*Q
fLRJ
H__inference_sequential_8_layer_call_and_return_conditional_losses_249888?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::22
StatefulPartitionedCallStatefulPartitionedCall: :- )
'
_user_specified_namedense_5_input: : : : : : : : :	 :
 : 
?"
?
H__inference_sequential_8_layer_call_and_return_conditional_losses_249930

inputs*
&dense_5_statefulpartitionedcall_args_1*
&dense_5_statefulpartitionedcall_args_2*
&dense_6_statefulpartitionedcall_args_1*
&dense_6_statefulpartitionedcall_args_2*
&dense_7_statefulpartitionedcall_args_1*
&dense_7_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_18
4batch_normalization_1_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_38
4batch_normalization_1_statefulpartitionedcall_args_4*
&dense_8_statefulpartitionedcall_args_1*
&dense_8_statefulpartitionedcall_args_2
identity??-batch_normalization_1/StatefulPartitionedCall?dense_5/StatefulPartitionedCall?dense_6/StatefulPartitionedCall?dense_7/StatefulPartitionedCall?dense_8/StatefulPartitionedCall?
dense_5/StatefulPartitionedCallStatefulPartitionedCallinputs&dense_5_statefulpartitionedcall_args_1&dense_5_statefulpartitionedcall_args_2**
config_proto

CPU

GPU 2J 8*
Tout
2*L
fGRE
C__inference_dense_5_layer_call_and_return_conditional_losses_249670*'
_output_shapes
:?????????*
Tin
2*-
_gradient_op_typePartitionedCall-249676?
dense_6/StatefulPartitionedCallStatefulPartitionedCall(dense_5/StatefulPartitionedCall:output:0&dense_6_statefulpartitionedcall_args_1&dense_6_statefulpartitionedcall_args_2*L
fGRE
C__inference_dense_6_layer_call_and_return_conditional_losses_249698*
Tin
2*-
_gradient_op_typePartitionedCall-249704*'
_output_shapes
:?????????
**
config_proto

CPU

GPU 2J 8*
Tout
2?
dense_7/StatefulPartitionedCallStatefulPartitionedCall(dense_6/StatefulPartitionedCall:output:0&dense_7_statefulpartitionedcall_args_1&dense_7_statefulpartitionedcall_args_2*-
_gradient_op_typePartitionedCall-249732**
config_proto

CPU

GPU 2J 8*
Tout
2*L
fGRE
C__inference_dense_7_layer_call_and_return_conditional_losses_249726*
Tin
2*(
_output_shapes
:???????????
-batch_normalization_1/StatefulPartitionedCallStatefulPartitionedCall(dense_7/StatefulPartitionedCall:output:04batch_normalization_1_statefulpartitionedcall_args_14batch_normalization_1_statefulpartitionedcall_args_24batch_normalization_1_statefulpartitionedcall_args_34batch_normalization_1_statefulpartitionedcall_args_4*(
_output_shapes
:??????????*-
_gradient_op_typePartitionedCall-249648**
config_proto

CPU

GPU 2J 8*
Tin	
2*
Tout
2*Z
fURS
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249647?
dropout_1/PartitionedCallPartitionedCall6batch_normalization_1/StatefulPartitionedCall:output:0*
Tin
2**
config_proto

CPU

GPU 2J 8*N
fIRG
E__inference_dropout_1_layer_call_and_return_conditional_losses_249793*
Tout
2*-
_gradient_op_typePartitionedCall-249805*(
_output_shapes
:???????????
dense_8/StatefulPartitionedCallStatefulPartitionedCall"dropout_1/PartitionedCall:output:0&dense_8_statefulpartitionedcall_args_1&dense_8_statefulpartitionedcall_args_2*'
_output_shapes
:?????????*-
_gradient_op_typePartitionedCall-249827*
Tout
2*L
fGRE
C__inference_dense_8_layer_call_and_return_conditional_losses_249821*
Tin
2**
config_proto

CPU

GPU 2J 8?
IdentityIdentity(dense_8/StatefulPartitionedCall:output:0.^batch_normalization_1/StatefulPartitionedCall ^dense_5/StatefulPartitionedCall ^dense_6/StatefulPartitionedCall ^dense_7/StatefulPartitionedCall ^dense_8/StatefulPartitionedCall*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2B
dense_6/StatefulPartitionedCalldense_6/StatefulPartitionedCall2B
dense_7/StatefulPartitionedCalldense_7/StatefulPartitionedCall2B
dense_8/StatefulPartitionedCalldense_8/StatefulPartitionedCall2^
-batch_normalization_1/StatefulPartitionedCall-batch_normalization_1/StatefulPartitionedCall2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall:& "
 
_user_specified_nameinputs: : : : : : : : :	 :
 : : 
?
?
$__inference_signature_wrapper_250007
dense_5_input"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4"
statefulpartitionedcall_args_5"
statefulpartitionedcall_args_6"
statefulpartitionedcall_args_7"
statefulpartitionedcall_args_8"
statefulpartitionedcall_args_9#
statefulpartitionedcall_args_10#
statefulpartitionedcall_args_11#
statefulpartitionedcall_args_12
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCalldense_5_inputstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4statefulpartitionedcall_args_5statefulpartitionedcall_args_6statefulpartitionedcall_args_7statefulpartitionedcall_args_8statefulpartitionedcall_args_9statefulpartitionedcall_args_10statefulpartitionedcall_args_11statefulpartitionedcall_args_12*
Tout
2**
f%R#
!__inference__wrapped_model_249499**
config_proto

CPU

GPU 2J 8*'
_output_shapes
:?????????*
Tin
2*-
_gradient_op_typePartitionedCall-249992?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::22
StatefulPartitionedCallStatefulPartitionedCall: : : : : : : :	 :
 : : :- )
'
_user_specified_namedense_5_input: 
?
?
-__inference_sequential_8_layer_call_fn_250180

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4"
statefulpartitionedcall_args_5"
statefulpartitionedcall_args_6"
statefulpartitionedcall_args_7"
statefulpartitionedcall_args_8"
statefulpartitionedcall_args_9#
statefulpartitionedcall_args_10#
statefulpartitionedcall_args_11#
statefulpartitionedcall_args_12
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4statefulpartitionedcall_args_5statefulpartitionedcall_args_6statefulpartitionedcall_args_7statefulpartitionedcall_args_8statefulpartitionedcall_args_9statefulpartitionedcall_args_10statefulpartitionedcall_args_11statefulpartitionedcall_args_12*
Tout
2*Q
fLRJ
H__inference_sequential_8_layer_call_and_return_conditional_losses_249930*'
_output_shapes
:?????????*-
_gradient_op_typePartitionedCall-249931*
Tin
2**
config_proto

CPU

GPU 2J 8?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs: : : : : : : : :	 :
 : : 
?"
?
H__inference_sequential_8_layer_call_and_return_conditional_losses_249863
dense_5_input*
&dense_5_statefulpartitionedcall_args_1*
&dense_5_statefulpartitionedcall_args_2*
&dense_6_statefulpartitionedcall_args_1*
&dense_6_statefulpartitionedcall_args_2*
&dense_7_statefulpartitionedcall_args_1*
&dense_7_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_18
4batch_normalization_1_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_38
4batch_normalization_1_statefulpartitionedcall_args_4*
&dense_8_statefulpartitionedcall_args_1*
&dense_8_statefulpartitionedcall_args_2
identity??-batch_normalization_1/StatefulPartitionedCall?dense_5/StatefulPartitionedCall?dense_6/StatefulPartitionedCall?dense_7/StatefulPartitionedCall?dense_8/StatefulPartitionedCall?
dense_5/StatefulPartitionedCallStatefulPartitionedCalldense_5_input&dense_5_statefulpartitionedcall_args_1&dense_5_statefulpartitionedcall_args_2*L
fGRE
C__inference_dense_5_layer_call_and_return_conditional_losses_249670*
Tin
2**
config_proto

CPU

GPU 2J 8*'
_output_shapes
:?????????*
Tout
2*-
_gradient_op_typePartitionedCall-249676?
dense_6/StatefulPartitionedCallStatefulPartitionedCall(dense_5/StatefulPartitionedCall:output:0&dense_6_statefulpartitionedcall_args_1&dense_6_statefulpartitionedcall_args_2*
Tout
2*L
fGRE
C__inference_dense_6_layer_call_and_return_conditional_losses_249698*-
_gradient_op_typePartitionedCall-249704**
config_proto

CPU

GPU 2J 8*
Tin
2*'
_output_shapes
:?????????
?
dense_7/StatefulPartitionedCallStatefulPartitionedCall(dense_6/StatefulPartitionedCall:output:0&dense_7_statefulpartitionedcall_args_1&dense_7_statefulpartitionedcall_args_2*
Tin
2*(
_output_shapes
:??????????*L
fGRE
C__inference_dense_7_layer_call_and_return_conditional_losses_249726*-
_gradient_op_typePartitionedCall-249732**
config_proto

CPU

GPU 2J 8*
Tout
2?
-batch_normalization_1/StatefulPartitionedCallStatefulPartitionedCall(dense_7/StatefulPartitionedCall:output:04batch_normalization_1_statefulpartitionedcall_args_14batch_normalization_1_statefulpartitionedcall_args_24batch_normalization_1_statefulpartitionedcall_args_34batch_normalization_1_statefulpartitionedcall_args_4**
config_proto

CPU

GPU 2J 8*
Tout
2*Z
fURS
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249647*
Tin	
2*(
_output_shapes
:??????????*-
_gradient_op_typePartitionedCall-249648?
dropout_1/PartitionedCallPartitionedCall6batch_normalization_1/StatefulPartitionedCall:output:0*N
fIRG
E__inference_dropout_1_layer_call_and_return_conditional_losses_249793*
Tout
2*(
_output_shapes
:??????????*
Tin
2**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249805?
dense_8/StatefulPartitionedCallStatefulPartitionedCall"dropout_1/PartitionedCall:output:0&dense_8_statefulpartitionedcall_args_1&dense_8_statefulpartitionedcall_args_2*L
fGRE
C__inference_dense_8_layer_call_and_return_conditional_losses_249821*'
_output_shapes
:?????????*
Tin
2*
Tout
2*-
_gradient_op_typePartitionedCall-249827**
config_proto

CPU

GPU 2J 8?
IdentityIdentity(dense_8/StatefulPartitionedCall:output:0.^batch_normalization_1/StatefulPartitionedCall ^dense_5/StatefulPartitionedCall ^dense_6/StatefulPartitionedCall ^dense_7/StatefulPartitionedCall ^dense_8/StatefulPartitionedCall*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2B
dense_8/StatefulPartitionedCalldense_8/StatefulPartitionedCall2^
-batch_normalization_1/StatefulPartitionedCall-batch_normalization_1/StatefulPartitionedCall2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall2B
dense_6/StatefulPartitionedCalldense_6/StatefulPartitionedCall2B
dense_7/StatefulPartitionedCalldense_7/StatefulPartitionedCall:- )
'
_user_specified_namedense_5_input: : : : : : : : :	 :
 : : 
?Q
?
!__inference__wrapped_model_249499
dense_5_input7
3sequential_8_dense_5_matmul_readvariableop_resource8
4sequential_8_dense_5_biasadd_readvariableop_resource7
3sequential_8_dense_6_matmul_readvariableop_resource8
4sequential_8_dense_6_biasadd_readvariableop_resource7
3sequential_8_dense_7_matmul_readvariableop_resource8
4sequential_8_dense_7_biasadd_readvariableop_resourceH
Dsequential_8_batch_normalization_1_batchnorm_readvariableop_resourceL
Hsequential_8_batch_normalization_1_batchnorm_mul_readvariableop_resourceJ
Fsequential_8_batch_normalization_1_batchnorm_readvariableop_1_resourceJ
Fsequential_8_batch_normalization_1_batchnorm_readvariableop_2_resource7
3sequential_8_dense_8_matmul_readvariableop_resource8
4sequential_8_dense_8_biasadd_readvariableop_resource
identity??;sequential_8/batch_normalization_1/batchnorm/ReadVariableOp?=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_1?=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_2??sequential_8/batch_normalization_1/batchnorm/mul/ReadVariableOp?+sequential_8/dense_5/BiasAdd/ReadVariableOp?*sequential_8/dense_5/MatMul/ReadVariableOp?+sequential_8/dense_6/BiasAdd/ReadVariableOp?*sequential_8/dense_6/MatMul/ReadVariableOp?+sequential_8/dense_7/BiasAdd/ReadVariableOp?*sequential_8/dense_7/MatMul/ReadVariableOp?+sequential_8/dense_8/BiasAdd/ReadVariableOp?*sequential_8/dense_8/MatMul/ReadVariableOp?
*sequential_8/dense_5/MatMul/ReadVariableOpReadVariableOp3sequential_8_dense_5_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	?p*
dtype0?
sequential_8/dense_5/MatMulMatMuldense_5_input2sequential_8/dense_5/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
+sequential_8/dense_5/BiasAdd/ReadVariableOpReadVariableOp4sequential_8_dense_5_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:*
dtype0?
sequential_8/dense_5/BiasAddBiasAdd%sequential_8/dense_5/MatMul:product:03sequential_8/dense_5/BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0z
sequential_8/dense_5/ReluRelu%sequential_8/dense_5/BiasAdd:output:0*'
_output_shapes
:?????????*
T0?
*sequential_8/dense_6/MatMul/ReadVariableOpReadVariableOp3sequential_8_dense_6_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes

:
?
sequential_8/dense_6/MatMulMatMul'sequential_8/dense_5/Relu:activations:02sequential_8/dense_6/MatMul/ReadVariableOp:value:0*'
_output_shapes
:?????????
*
T0?
+sequential_8/dense_6/BiasAdd/ReadVariableOpReadVariableOp4sequential_8_dense_6_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:
*
dtype0?
sequential_8/dense_6/BiasAddBiasAdd%sequential_8/dense_6/MatMul:product:03sequential_8/dense_6/BiasAdd/ReadVariableOp:value:0*'
_output_shapes
:?????????
*
T0z
sequential_8/dense_6/TanhTanh%sequential_8/dense_6/BiasAdd:output:0*
T0*'
_output_shapes
:?????????
?
*sequential_8/dense_7/MatMul/ReadVariableOpReadVariableOp3sequential_8_dense_7_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:	
?*
dtype0?
sequential_8/dense_7/MatMulMatMulsequential_8/dense_6/Tanh:y:02sequential_8/dense_7/MatMul/ReadVariableOp:value:0*(
_output_shapes
:??????????*
T0?
+sequential_8/dense_7/BiasAdd/ReadVariableOpReadVariableOp4sequential_8_dense_7_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
sequential_8/dense_7/BiasAddBiasAdd%sequential_8/dense_7/MatMul:product:03sequential_8/dense_7/BiasAdd/ReadVariableOp:value:0*(
_output_shapes
:??????????*
T0{
sequential_8/dense_7/ReluRelu%sequential_8/dense_7/BiasAdd:output:0*
T0*(
_output_shapes
:??????????q
/sequential_8/batch_normalization_1/LogicalAnd/xConst*
dtype0
*
_output_shapes
: *
value	B
 Z q
/sequential_8/batch_normalization_1/LogicalAnd/yConst*
value	B
 Z*
_output_shapes
: *
dtype0
?
-sequential_8/batch_normalization_1/LogicalAnd
LogicalAnd8sequential_8/batch_normalization_1/LogicalAnd/x:output:08sequential_8/batch_normalization_1/LogicalAnd/y:output:0*
_output_shapes
: ?
;sequential_8/batch_normalization_1/batchnorm/ReadVariableOpReadVariableOpDsequential_8_batch_normalization_1_batchnorm_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:?w
2sequential_8/batch_normalization_1/batchnorm/add/yConst*
valueB
 *o?:*
dtype0*
_output_shapes
: ?
0sequential_8/batch_normalization_1/batchnorm/addAddV2Csequential_8/batch_normalization_1/batchnorm/ReadVariableOp:value:0;sequential_8/batch_normalization_1/batchnorm/add/y:output:0*
T0*
_output_shapes	
:??
2sequential_8/batch_normalization_1/batchnorm/RsqrtRsqrt4sequential_8/batch_normalization_1/batchnorm/add:z:0*
_output_shapes	
:?*
T0?
?sequential_8/batch_normalization_1/batchnorm/mul/ReadVariableOpReadVariableOpHsequential_8_batch_normalization_1_batchnorm_mul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes	
:?*
dtype0?
0sequential_8/batch_normalization_1/batchnorm/mulMul6sequential_8/batch_normalization_1/batchnorm/Rsqrt:y:0Gsequential_8/batch_normalization_1/batchnorm/mul/ReadVariableOp:value:0*
T0*
_output_shapes	
:??
2sequential_8/batch_normalization_1/batchnorm/mul_1Mul'sequential_8/dense_7/Relu:activations:04sequential_8/batch_normalization_1/batchnorm/mul:z:0*(
_output_shapes
:??????????*
T0?
=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_1ReadVariableOpFsequential_8_batch_normalization_1_batchnorm_readvariableop_1_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
2sequential_8/batch_normalization_1/batchnorm/mul_2MulEsequential_8/batch_normalization_1/batchnorm/ReadVariableOp_1:value:04sequential_8/batch_normalization_1/batchnorm/mul:z:0*
T0*
_output_shapes	
:??
=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_2ReadVariableOpFsequential_8_batch_normalization_1_batchnorm_readvariableop_2_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes	
:??
0sequential_8/batch_normalization_1/batchnorm/subSubEsequential_8/batch_normalization_1/batchnorm/ReadVariableOp_2:value:06sequential_8/batch_normalization_1/batchnorm/mul_2:z:0*
_output_shapes	
:?*
T0?
2sequential_8/batch_normalization_1/batchnorm/add_1AddV26sequential_8/batch_normalization_1/batchnorm/mul_1:z:04sequential_8/batch_normalization_1/batchnorm/sub:z:0*(
_output_shapes
:??????????*
T0?
sequential_8/dropout_1/IdentityIdentity6sequential_8/batch_normalization_1/batchnorm/add_1:z:0*(
_output_shapes
:??????????*
T0?
*sequential_8/dense_8/MatMul/ReadVariableOpReadVariableOp3sequential_8_dense_8_matmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:	??
sequential_8/dense_8/MatMulMatMul(sequential_8/dropout_1/Identity:output:02sequential_8/dense_8/MatMul/ReadVariableOp:value:0*'
_output_shapes
:?????????*
T0?
+sequential_8/dense_8/BiasAdd/ReadVariableOpReadVariableOp4sequential_8_dense_8_biasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes
:?
sequential_8/dense_8/BiasAddBiasAdd%sequential_8/dense_8/MatMul:product:03sequential_8/dense_8/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:??????????
sequential_8/dense_8/SigmoidSigmoid%sequential_8/dense_8/BiasAdd:output:0*
T0*'
_output_shapes
:??????????
IdentityIdentity sequential_8/dense_8/Sigmoid:y:0<^sequential_8/batch_normalization_1/batchnorm/ReadVariableOp>^sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_1>^sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_2@^sequential_8/batch_normalization_1/batchnorm/mul/ReadVariableOp,^sequential_8/dense_5/BiasAdd/ReadVariableOp+^sequential_8/dense_5/MatMul/ReadVariableOp,^sequential_8/dense_6/BiasAdd/ReadVariableOp+^sequential_8/dense_6/MatMul/ReadVariableOp,^sequential_8/dense_7/BiasAdd/ReadVariableOp+^sequential_8/dense_7/MatMul/ReadVariableOp,^sequential_8/dense_8/BiasAdd/ReadVariableOp+^sequential_8/dense_8/MatMul/ReadVariableOp*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2X
*sequential_8/dense_6/MatMul/ReadVariableOp*sequential_8/dense_6/MatMul/ReadVariableOp2Z
+sequential_8/dense_8/BiasAdd/ReadVariableOp+sequential_8/dense_8/BiasAdd/ReadVariableOp2Z
+sequential_8/dense_6/BiasAdd/ReadVariableOp+sequential_8/dense_6/BiasAdd/ReadVariableOp2X
*sequential_8/dense_7/MatMul/ReadVariableOp*sequential_8/dense_7/MatMul/ReadVariableOp2~
=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_1=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_12~
=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_2=sequential_8/batch_normalization_1/batchnorm/ReadVariableOp_22z
;sequential_8/batch_normalization_1/batchnorm/ReadVariableOp;sequential_8/batch_normalization_1/batchnorm/ReadVariableOp2X
*sequential_8/dense_8/MatMul/ReadVariableOp*sequential_8/dense_8/MatMul/ReadVariableOp2Z
+sequential_8/dense_7/BiasAdd/ReadVariableOp+sequential_8/dense_7/BiasAdd/ReadVariableOp2X
*sequential_8/dense_5/MatMul/ReadVariableOp*sequential_8/dense_5/MatMul/ReadVariableOp2Z
+sequential_8/dense_5/BiasAdd/ReadVariableOp+sequential_8/dense_5/BiasAdd/ReadVariableOp2?
?sequential_8/batch_normalization_1/batchnorm/mul/ReadVariableOp?sequential_8/batch_normalization_1/batchnorm/mul/ReadVariableOp: :- )
'
_user_specified_namedense_5_input: : : : : : : : :	 :
 : 
?
c
E__inference_dropout_1_layer_call_and_return_conditional_losses_249793

inputs

identity_1O
IdentityIdentityinputs*(
_output_shapes
:??????????*
T0\

Identity_1IdentityIdentity:output:0*(
_output_shapes
:??????????*
T0"!

identity_1Identity_1:output:0*'
_input_shapes
:??????????:& "
 
_user_specified_nameinputs
?#
?
H__inference_sequential_8_layer_call_and_return_conditional_losses_249839
dense_5_input*
&dense_5_statefulpartitionedcall_args_1*
&dense_5_statefulpartitionedcall_args_2*
&dense_6_statefulpartitionedcall_args_1*
&dense_6_statefulpartitionedcall_args_2*
&dense_7_statefulpartitionedcall_args_1*
&dense_7_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_18
4batch_normalization_1_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_38
4batch_normalization_1_statefulpartitionedcall_args_4*
&dense_8_statefulpartitionedcall_args_1*
&dense_8_statefulpartitionedcall_args_2
identity??-batch_normalization_1/StatefulPartitionedCall?dense_5/StatefulPartitionedCall?dense_6/StatefulPartitionedCall?dense_7/StatefulPartitionedCall?dense_8/StatefulPartitionedCall?!dropout_1/StatefulPartitionedCall?
dense_5/StatefulPartitionedCallStatefulPartitionedCalldense_5_input&dense_5_statefulpartitionedcall_args_1&dense_5_statefulpartitionedcall_args_2*
Tin
2*L
fGRE
C__inference_dense_5_layer_call_and_return_conditional_losses_249670*-
_gradient_op_typePartitionedCall-249676**
config_proto

CPU

GPU 2J 8*
Tout
2*'
_output_shapes
:??????????
dense_6/StatefulPartitionedCallStatefulPartitionedCall(dense_5/StatefulPartitionedCall:output:0&dense_6_statefulpartitionedcall_args_1&dense_6_statefulpartitionedcall_args_2*L
fGRE
C__inference_dense_6_layer_call_and_return_conditional_losses_249698*
Tin
2*
Tout
2*-
_gradient_op_typePartitionedCall-249704*'
_output_shapes
:?????????
**
config_proto

CPU

GPU 2J 8?
dense_7/StatefulPartitionedCallStatefulPartitionedCall(dense_6/StatefulPartitionedCall:output:0&dense_7_statefulpartitionedcall_args_1&dense_7_statefulpartitionedcall_args_2*L
fGRE
C__inference_dense_7_layer_call_and_return_conditional_losses_249726*
Tin
2*-
_gradient_op_typePartitionedCall-249732**
config_proto

CPU

GPU 2J 8*(
_output_shapes
:??????????*
Tout
2?
-batch_normalization_1/StatefulPartitionedCallStatefulPartitionedCall(dense_7/StatefulPartitionedCall:output:04batch_normalization_1_statefulpartitionedcall_args_14batch_normalization_1_statefulpartitionedcall_args_24batch_normalization_1_statefulpartitionedcall_args_34batch_normalization_1_statefulpartitionedcall_args_4*Z
fURS
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249612*
Tin	
2**
config_proto

CPU

GPU 2J 8*(
_output_shapes
:??????????*
Tout
2*-
_gradient_op_typePartitionedCall-249613?
!dropout_1/StatefulPartitionedCallStatefulPartitionedCall6batch_normalization_1/StatefulPartitionedCall:output:0*
Tin
2*-
_gradient_op_typePartitionedCall-249797**
config_proto

CPU

GPU 2J 8*(
_output_shapes
:??????????*
Tout
2*N
fIRG
E__inference_dropout_1_layer_call_and_return_conditional_losses_249786?
dense_8/StatefulPartitionedCallStatefulPartitionedCall*dropout_1/StatefulPartitionedCall:output:0&dense_8_statefulpartitionedcall_args_1&dense_8_statefulpartitionedcall_args_2*
Tout
2**
config_proto

CPU

GPU 2J 8*'
_output_shapes
:?????????*
Tin
2*-
_gradient_op_typePartitionedCall-249827*L
fGRE
C__inference_dense_8_layer_call_and_return_conditional_losses_249821?
IdentityIdentity(dense_8/StatefulPartitionedCall:output:0.^batch_normalization_1/StatefulPartitionedCall ^dense_5/StatefulPartitionedCall ^dense_6/StatefulPartitionedCall ^dense_7/StatefulPartitionedCall ^dense_8/StatefulPartitionedCall"^dropout_1/StatefulPartitionedCall*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall2B
dense_6/StatefulPartitionedCalldense_6/StatefulPartitionedCall2B
dense_7/StatefulPartitionedCalldense_7/StatefulPartitionedCall2B
dense_8/StatefulPartitionedCalldense_8/StatefulPartitionedCall2^
-batch_normalization_1/StatefulPartitionedCall-batch_normalization_1/StatefulPartitionedCall2F
!dropout_1/StatefulPartitionedCall!dropout_1/StatefulPartitionedCall: : : : : :	 :
 : : :- )
'
_user_specified_namedense_5_input: : : 
?
d
E__inference_dropout_1_layer_call_and_return_conditional_losses_249786

inputs
identity?Q
dropout/rateConst*
dtype0*
_output_shapes
: *
valueB
 *   ?C
dropout/ShapeShapeinputs*
_output_shapes
:*
T0_
dropout/random_uniform/minConst*
valueB
 *    *
dtype0*
_output_shapes
: _
dropout/random_uniform/maxConst*
_output_shapes
: *
valueB
 *  ??*
dtype0?
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*(
_output_shapes
:??????????*
dtype0*
T0?
dropout/random_uniform/subSub#dropout/random_uniform/max:output:0#dropout/random_uniform/min:output:0*
T0*
_output_shapes
: ?
dropout/random_uniform/mulMul-dropout/random_uniform/RandomUniform:output:0dropout/random_uniform/sub:z:0*(
_output_shapes
:??????????*
T0?
dropout/random_uniformAdddropout/random_uniform/mul:z:0#dropout/random_uniform/min:output:0*(
_output_shapes
:??????????*
T0R
dropout/sub/xConst*
valueB
 *  ??*
dtype0*
_output_shapes
: b
dropout/subSubdropout/sub/x:output:0dropout/rate:output:0*
T0*
_output_shapes
: V
dropout/truediv/xConst*
valueB
 *  ??*
_output_shapes
: *
dtype0h
dropout/truedivRealDivdropout/truediv/x:output:0dropout/sub:z:0*
_output_shapes
: *
T0?
dropout/GreaterEqualGreaterEqualdropout/random_uniform:z:0dropout/rate:output:0*(
_output_shapes
:??????????*
T0b
dropout/mulMulinputsdropout/truediv:z:0*
T0*(
_output_shapes
:??????????p
dropout/CastCastdropout/GreaterEqual:z:0*

SrcT0
*

DstT0*(
_output_shapes
:??????????j
dropout/mul_1Muldropout/mul:z:0dropout/Cast:y:0*(
_output_shapes
:??????????*
T0Z
IdentityIdentitydropout/mul_1:z:0*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*'
_input_shapes
:??????????:& "
 
_user_specified_nameinputs
?	
?
C__inference_dense_6_layer_call_and_return_conditional_losses_250209

inputs"
matmul_readvariableop_resource#
biasadd_readvariableop_resource
identity??BiasAdd/ReadVariableOp?MatMul/ReadVariableOp?
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
dtype0*
_output_shapes

:
i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????
?
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource",/job:localhost/replica:0/task:0/device:CPU:0*
_output_shapes
:
*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:?????????
P
TanhTanhBiasAdd:output:0*'
_output_shapes
:?????????
*
T0?
IdentityIdentityTanh:y:0^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*'
_output_shapes
:?????????
*
T0"
identityIdentity:output:0*.
_input_shapes
:?????????::2.
MatMul/ReadVariableOpMatMul/ReadVariableOp20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp:& "
 
_user_specified_nameinputs: : 
?
?
(__inference_dense_8_layer_call_fn_250407

inputs"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputsstatefulpartitionedcall_args_1statefulpartitionedcall_args_2*'
_output_shapes
:?????????*
Tout
2**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249827*L
fGRE
C__inference_dense_8_layer_call_and_return_conditional_losses_249821*
Tin
2?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*/
_input_shapes
:??????????::22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs: : 
?
c
*__inference_dropout_1_layer_call_fn_250384

inputs
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputs*-
_gradient_op_typePartitionedCall-249797*N
fIRG
E__inference_dropout_1_layer_call_and_return_conditional_losses_249786*(
_output_shapes
:??????????*
Tout
2*
Tin
2**
config_proto

CPU

GPU 2J 8?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*(
_output_shapes
:??????????"
identityIdentity:output:0*'
_input_shapes
:??????????22
StatefulPartitionedCallStatefulPartitionedCall:& "
 
_user_specified_nameinputs
??
?
"__inference__traced_restore_250679
file_prefix#
assignvariableop_dense_5_kernel#
assignvariableop_1_dense_5_bias%
!assignvariableop_2_dense_6_kernel#
assignvariableop_3_dense_6_bias%
!assignvariableop_4_dense_7_kernel#
assignvariableop_5_dense_7_bias2
.assignvariableop_6_batch_normalization_1_gamma1
-assignvariableop_7_batch_normalization_1_beta8
4assignvariableop_8_batch_normalization_1_moving_mean<
8assignvariableop_9_batch_normalization_1_moving_variance&
"assignvariableop_10_dense_8_kernel$
 assignvariableop_11_dense_8_bias,
(assignvariableop_12_training_1_adam_iter.
*assignvariableop_13_training_1_adam_beta_1.
*assignvariableop_14_training_1_adam_beta_2-
)assignvariableop_15_training_1_adam_decay5
1assignvariableop_16_training_1_adam_learning_rate
assignvariableop_17_total
assignvariableop_18_count8
4assignvariableop_19_training_1_adam_dense_5_kernel_m6
2assignvariableop_20_training_1_adam_dense_5_bias_m8
4assignvariableop_21_training_1_adam_dense_6_kernel_m6
2assignvariableop_22_training_1_adam_dense_6_bias_m8
4assignvariableop_23_training_1_adam_dense_7_kernel_m6
2assignvariableop_24_training_1_adam_dense_7_bias_mE
Aassignvariableop_25_training_1_adam_batch_normalization_1_gamma_mD
@assignvariableop_26_training_1_adam_batch_normalization_1_beta_m8
4assignvariableop_27_training_1_adam_dense_8_kernel_m6
2assignvariableop_28_training_1_adam_dense_8_bias_m8
4assignvariableop_29_training_1_adam_dense_5_kernel_v6
2assignvariableop_30_training_1_adam_dense_5_bias_v8
4assignvariableop_31_training_1_adam_dense_6_kernel_v6
2assignvariableop_32_training_1_adam_dense_6_bias_v8
4assignvariableop_33_training_1_adam_dense_7_kernel_v6
2assignvariableop_34_training_1_adam_dense_7_bias_vE
Aassignvariableop_35_training_1_adam_batch_normalization_1_gamma_vD
@assignvariableop_36_training_1_adam_batch_normalization_1_beta_v8
4assignvariableop_37_training_1_adam_dense_8_kernel_v6
2assignvariableop_38_training_1_adam_dense_8_bias_v
identity_40??AssignVariableOp?AssignVariableOp_1?AssignVariableOp_10?AssignVariableOp_11?AssignVariableOp_12?AssignVariableOp_13?AssignVariableOp_14?AssignVariableOp_15?AssignVariableOp_16?AssignVariableOp_17?AssignVariableOp_18?AssignVariableOp_19?AssignVariableOp_2?AssignVariableOp_20?AssignVariableOp_21?AssignVariableOp_22?AssignVariableOp_23?AssignVariableOp_24?AssignVariableOp_25?AssignVariableOp_26?AssignVariableOp_27?AssignVariableOp_28?AssignVariableOp_29?AssignVariableOp_3?AssignVariableOp_30?AssignVariableOp_31?AssignVariableOp_32?AssignVariableOp_33?AssignVariableOp_34?AssignVariableOp_35?AssignVariableOp_36?AssignVariableOp_37?AssignVariableOp_38?AssignVariableOp_4?AssignVariableOp_5?AssignVariableOp_6?AssignVariableOp_7?AssignVariableOp_8?AssignVariableOp_9?	RestoreV2?RestoreV2_1?
RestoreV2/tensor_namesConst"/device:CPU:0*?
value?B?'B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB5layer_with_weights-3/gamma/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-3/beta/.ATTRIBUTES/VARIABLE_VALUEB;layer_with_weights-3/moving_mean/.ATTRIBUTES/VARIABLE_VALUEB?layer_with_weights-3/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-4/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_1/.ATTRIBUTES/VARIABLE_VALUEB+optimizer/beta_2/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBQlayer_with_weights-3/gamma/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/beta/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/m/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBQlayer_with_weights-3/gamma/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-3/beta/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-4/kernel/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUEBPlayer_with_weights-4/bias/.OPTIMIZER_SLOT/optimizer/v/.ATTRIBUTES/VARIABLE_VALUE*
_output_shapes
:'*
dtype0?
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:'*
dtype0*a
valueXBV'B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B ?
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*?
_output_shapes?
?:::::::::::::::::::::::::::::::::::::::*5
dtypes+
)2'	L
IdentityIdentityRestoreV2:tensors:0*
T0*
_output_shapes
:{
AssignVariableOpAssignVariableOpassignvariableop_dense_5_kernelIdentity:output:0*
_output_shapes
 *
dtype0N

Identity_1IdentityRestoreV2:tensors:1*
_output_shapes
:*
T0
AssignVariableOp_1AssignVariableOpassignvariableop_1_dense_5_biasIdentity_1:output:0*
dtype0*
_output_shapes
 N

Identity_2IdentityRestoreV2:tensors:2*
T0*
_output_shapes
:?
AssignVariableOp_2AssignVariableOp!assignvariableop_2_dense_6_kernelIdentity_2:output:0*
dtype0*
_output_shapes
 N

Identity_3IdentityRestoreV2:tensors:3*
_output_shapes
:*
T0
AssignVariableOp_3AssignVariableOpassignvariableop_3_dense_6_biasIdentity_3:output:0*
dtype0*
_output_shapes
 N

Identity_4IdentityRestoreV2:tensors:4*
T0*
_output_shapes
:?
AssignVariableOp_4AssignVariableOp!assignvariableop_4_dense_7_kernelIdentity_4:output:0*
dtype0*
_output_shapes
 N

Identity_5IdentityRestoreV2:tensors:5*
T0*
_output_shapes
:
AssignVariableOp_5AssignVariableOpassignvariableop_5_dense_7_biasIdentity_5:output:0*
dtype0*
_output_shapes
 N

Identity_6IdentityRestoreV2:tensors:6*
T0*
_output_shapes
:?
AssignVariableOp_6AssignVariableOp.assignvariableop_6_batch_normalization_1_gammaIdentity_6:output:0*
_output_shapes
 *
dtype0N

Identity_7IdentityRestoreV2:tensors:7*
T0*
_output_shapes
:?
AssignVariableOp_7AssignVariableOp-assignvariableop_7_batch_normalization_1_betaIdentity_7:output:0*
_output_shapes
 *
dtype0N

Identity_8IdentityRestoreV2:tensors:8*
_output_shapes
:*
T0?
AssignVariableOp_8AssignVariableOp4assignvariableop_8_batch_normalization_1_moving_meanIdentity_8:output:0*
_output_shapes
 *
dtype0N

Identity_9IdentityRestoreV2:tensors:9*
T0*
_output_shapes
:?
AssignVariableOp_9AssignVariableOp8assignvariableop_9_batch_normalization_1_moving_varianceIdentity_9:output:0*
dtype0*
_output_shapes
 P
Identity_10IdentityRestoreV2:tensors:10*
_output_shapes
:*
T0?
AssignVariableOp_10AssignVariableOp"assignvariableop_10_dense_8_kernelIdentity_10:output:0*
_output_shapes
 *
dtype0P
Identity_11IdentityRestoreV2:tensors:11*
_output_shapes
:*
T0?
AssignVariableOp_11AssignVariableOp assignvariableop_11_dense_8_biasIdentity_11:output:0*
_output_shapes
 *
dtype0P
Identity_12IdentityRestoreV2:tensors:12*
T0	*
_output_shapes
:?
AssignVariableOp_12AssignVariableOp(assignvariableop_12_training_1_adam_iterIdentity_12:output:0*
_output_shapes
 *
dtype0	P
Identity_13IdentityRestoreV2:tensors:13*
T0*
_output_shapes
:?
AssignVariableOp_13AssignVariableOp*assignvariableop_13_training_1_adam_beta_1Identity_13:output:0*
dtype0*
_output_shapes
 P
Identity_14IdentityRestoreV2:tensors:14*
_output_shapes
:*
T0?
AssignVariableOp_14AssignVariableOp*assignvariableop_14_training_1_adam_beta_2Identity_14:output:0*
dtype0*
_output_shapes
 P
Identity_15IdentityRestoreV2:tensors:15*
T0*
_output_shapes
:?
AssignVariableOp_15AssignVariableOp)assignvariableop_15_training_1_adam_decayIdentity_15:output:0*
dtype0*
_output_shapes
 P
Identity_16IdentityRestoreV2:tensors:16*
_output_shapes
:*
T0?
AssignVariableOp_16AssignVariableOp1assignvariableop_16_training_1_adam_learning_rateIdentity_16:output:0*
_output_shapes
 *
dtype0P
Identity_17IdentityRestoreV2:tensors:17*
_output_shapes
:*
T0{
AssignVariableOp_17AssignVariableOpassignvariableop_17_totalIdentity_17:output:0*
_output_shapes
 *
dtype0P
Identity_18IdentityRestoreV2:tensors:18*
_output_shapes
:*
T0{
AssignVariableOp_18AssignVariableOpassignvariableop_18_countIdentity_18:output:0*
_output_shapes
 *
dtype0P
Identity_19IdentityRestoreV2:tensors:19*
T0*
_output_shapes
:?
AssignVariableOp_19AssignVariableOp4assignvariableop_19_training_1_adam_dense_5_kernel_mIdentity_19:output:0*
dtype0*
_output_shapes
 P
Identity_20IdentityRestoreV2:tensors:20*
_output_shapes
:*
T0?
AssignVariableOp_20AssignVariableOp2assignvariableop_20_training_1_adam_dense_5_bias_mIdentity_20:output:0*
_output_shapes
 *
dtype0P
Identity_21IdentityRestoreV2:tensors:21*
T0*
_output_shapes
:?
AssignVariableOp_21AssignVariableOp4assignvariableop_21_training_1_adam_dense_6_kernel_mIdentity_21:output:0*
dtype0*
_output_shapes
 P
Identity_22IdentityRestoreV2:tensors:22*
_output_shapes
:*
T0?
AssignVariableOp_22AssignVariableOp2assignvariableop_22_training_1_adam_dense_6_bias_mIdentity_22:output:0*
dtype0*
_output_shapes
 P
Identity_23IdentityRestoreV2:tensors:23*
T0*
_output_shapes
:?
AssignVariableOp_23AssignVariableOp4assignvariableop_23_training_1_adam_dense_7_kernel_mIdentity_23:output:0*
dtype0*
_output_shapes
 P
Identity_24IdentityRestoreV2:tensors:24*
T0*
_output_shapes
:?
AssignVariableOp_24AssignVariableOp2assignvariableop_24_training_1_adam_dense_7_bias_mIdentity_24:output:0*
dtype0*
_output_shapes
 P
Identity_25IdentityRestoreV2:tensors:25*
_output_shapes
:*
T0?
AssignVariableOp_25AssignVariableOpAassignvariableop_25_training_1_adam_batch_normalization_1_gamma_mIdentity_25:output:0*
dtype0*
_output_shapes
 P
Identity_26IdentityRestoreV2:tensors:26*
T0*
_output_shapes
:?
AssignVariableOp_26AssignVariableOp@assignvariableop_26_training_1_adam_batch_normalization_1_beta_mIdentity_26:output:0*
_output_shapes
 *
dtype0P
Identity_27IdentityRestoreV2:tensors:27*
T0*
_output_shapes
:?
AssignVariableOp_27AssignVariableOp4assignvariableop_27_training_1_adam_dense_8_kernel_mIdentity_27:output:0*
dtype0*
_output_shapes
 P
Identity_28IdentityRestoreV2:tensors:28*
_output_shapes
:*
T0?
AssignVariableOp_28AssignVariableOp2assignvariableop_28_training_1_adam_dense_8_bias_mIdentity_28:output:0*
_output_shapes
 *
dtype0P
Identity_29IdentityRestoreV2:tensors:29*
T0*
_output_shapes
:?
AssignVariableOp_29AssignVariableOp4assignvariableop_29_training_1_adam_dense_5_kernel_vIdentity_29:output:0*
dtype0*
_output_shapes
 P
Identity_30IdentityRestoreV2:tensors:30*
T0*
_output_shapes
:?
AssignVariableOp_30AssignVariableOp2assignvariableop_30_training_1_adam_dense_5_bias_vIdentity_30:output:0*
_output_shapes
 *
dtype0P
Identity_31IdentityRestoreV2:tensors:31*
T0*
_output_shapes
:?
AssignVariableOp_31AssignVariableOp4assignvariableop_31_training_1_adam_dense_6_kernel_vIdentity_31:output:0*
_output_shapes
 *
dtype0P
Identity_32IdentityRestoreV2:tensors:32*
_output_shapes
:*
T0?
AssignVariableOp_32AssignVariableOp2assignvariableop_32_training_1_adam_dense_6_bias_vIdentity_32:output:0*
dtype0*
_output_shapes
 P
Identity_33IdentityRestoreV2:tensors:33*
T0*
_output_shapes
:?
AssignVariableOp_33AssignVariableOp4assignvariableop_33_training_1_adam_dense_7_kernel_vIdentity_33:output:0*
_output_shapes
 *
dtype0P
Identity_34IdentityRestoreV2:tensors:34*
T0*
_output_shapes
:?
AssignVariableOp_34AssignVariableOp2assignvariableop_34_training_1_adam_dense_7_bias_vIdentity_34:output:0*
_output_shapes
 *
dtype0P
Identity_35IdentityRestoreV2:tensors:35*
_output_shapes
:*
T0?
AssignVariableOp_35AssignVariableOpAassignvariableop_35_training_1_adam_batch_normalization_1_gamma_vIdentity_35:output:0*
dtype0*
_output_shapes
 P
Identity_36IdentityRestoreV2:tensors:36*
T0*
_output_shapes
:?
AssignVariableOp_36AssignVariableOp@assignvariableop_36_training_1_adam_batch_normalization_1_beta_vIdentity_36:output:0*
_output_shapes
 *
dtype0P
Identity_37IdentityRestoreV2:tensors:37*
_output_shapes
:*
T0?
AssignVariableOp_37AssignVariableOp4assignvariableop_37_training_1_adam_dense_8_kernel_vIdentity_37:output:0*
dtype0*
_output_shapes
 P
Identity_38IdentityRestoreV2:tensors:38*
_output_shapes
:*
T0?
AssignVariableOp_38AssignVariableOp2assignvariableop_38_training_1_adam_dense_8_bias_vIdentity_38:output:0*
_output_shapes
 *
dtype0?
RestoreV2_1/tensor_namesConst"/device:CPU:0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPH*
dtype0*
_output_shapes
:t
RestoreV2_1/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B ?
RestoreV2_1	RestoreV2file_prefix!RestoreV2_1/tensor_names:output:0%RestoreV2_1/shape_and_slices:output:0
^RestoreV2"/device:CPU:0*
dtypes
2*
_output_shapes
:1
NoOpNoOp"/device:CPU:0*
_output_shapes
 ?
Identity_39Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_33^AssignVariableOp_34^AssignVariableOp_35^AssignVariableOp_36^AssignVariableOp_37^AssignVariableOp_38^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: ?
Identity_40IdentityIdentity_39:output:0^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_33^AssignVariableOp_34^AssignVariableOp_35^AssignVariableOp_36^AssignVariableOp_37^AssignVariableOp_38^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9
^RestoreV2^RestoreV2_1*
_output_shapes
: *
T0"#
identity_40Identity_40:output:0*?
_input_shapes?
?: :::::::::::::::::::::::::::::::::::::::2(
AssignVariableOp_9AssignVariableOp_92
	RestoreV2	RestoreV22*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122
RestoreV2_1RestoreV2_12*
AssignVariableOp_13AssignVariableOp_132*
AssignVariableOp_14AssignVariableOp_142*
AssignVariableOp_15AssignVariableOp_152*
AssignVariableOp_20AssignVariableOp_202*
AssignVariableOp_21AssignVariableOp_212*
AssignVariableOp_16AssignVariableOp_162*
AssignVariableOp_17AssignVariableOp_172*
AssignVariableOp_22AssignVariableOp_222*
AssignVariableOp_18AssignVariableOp_182*
AssignVariableOp_23AssignVariableOp_232*
AssignVariableOp_24AssignVariableOp_242*
AssignVariableOp_19AssignVariableOp_192*
AssignVariableOp_25AssignVariableOp_252*
AssignVariableOp_30AssignVariableOp_302*
AssignVariableOp_26AssignVariableOp_262*
AssignVariableOp_31AssignVariableOp_312*
AssignVariableOp_32AssignVariableOp_322$
AssignVariableOpAssignVariableOp2*
AssignVariableOp_27AssignVariableOp_272*
AssignVariableOp_33AssignVariableOp_332*
AssignVariableOp_28AssignVariableOp_282*
AssignVariableOp_29AssignVariableOp_292*
AssignVariableOp_34AssignVariableOp_342*
AssignVariableOp_35AssignVariableOp_352*
AssignVariableOp_36AssignVariableOp_362*
AssignVariableOp_37AssignVariableOp_372*
AssignVariableOp_38AssignVariableOp_382(
AssignVariableOp_1AssignVariableOp_12(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_8:& :' :+ '
%
_user_specified_namefile_prefix: : : : : : : : :	 :
 : : : : : : : : : : : : : : : : : : : : : :  :! :" :# :$ :% 
?#
?
H__inference_sequential_8_layer_call_and_return_conditional_losses_249888

inputs*
&dense_5_statefulpartitionedcall_args_1*
&dense_5_statefulpartitionedcall_args_2*
&dense_6_statefulpartitionedcall_args_1*
&dense_6_statefulpartitionedcall_args_2*
&dense_7_statefulpartitionedcall_args_1*
&dense_7_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_18
4batch_normalization_1_statefulpartitionedcall_args_28
4batch_normalization_1_statefulpartitionedcall_args_38
4batch_normalization_1_statefulpartitionedcall_args_4*
&dense_8_statefulpartitionedcall_args_1*
&dense_8_statefulpartitionedcall_args_2
identity??-batch_normalization_1/StatefulPartitionedCall?dense_5/StatefulPartitionedCall?dense_6/StatefulPartitionedCall?dense_7/StatefulPartitionedCall?dense_8/StatefulPartitionedCall?!dropout_1/StatefulPartitionedCall?
dense_5/StatefulPartitionedCallStatefulPartitionedCallinputs&dense_5_statefulpartitionedcall_args_1&dense_5_statefulpartitionedcall_args_2*-
_gradient_op_typePartitionedCall-249676*
Tout
2*L
fGRE
C__inference_dense_5_layer_call_and_return_conditional_losses_249670*'
_output_shapes
:?????????**
config_proto

CPU

GPU 2J 8*
Tin
2?
dense_6/StatefulPartitionedCallStatefulPartitionedCall(dense_5/StatefulPartitionedCall:output:0&dense_6_statefulpartitionedcall_args_1&dense_6_statefulpartitionedcall_args_2**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249704*
Tin
2*L
fGRE
C__inference_dense_6_layer_call_and_return_conditional_losses_249698*
Tout
2*'
_output_shapes
:?????????
?
dense_7/StatefulPartitionedCallStatefulPartitionedCall(dense_6/StatefulPartitionedCall:output:0&dense_7_statefulpartitionedcall_args_1&dense_7_statefulpartitionedcall_args_2*L
fGRE
C__inference_dense_7_layer_call_and_return_conditional_losses_249726**
config_proto

CPU

GPU 2J 8*
Tin
2*
Tout
2*(
_output_shapes
:??????????*-
_gradient_op_typePartitionedCall-249732?
-batch_normalization_1/StatefulPartitionedCallStatefulPartitionedCall(dense_7/StatefulPartitionedCall:output:04batch_normalization_1_statefulpartitionedcall_args_14batch_normalization_1_statefulpartitionedcall_args_24batch_normalization_1_statefulpartitionedcall_args_34batch_normalization_1_statefulpartitionedcall_args_4*
Tin	
2*Z
fURS
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_249612**
config_proto

CPU

GPU 2J 8*-
_gradient_op_typePartitionedCall-249613*(
_output_shapes
:??????????*
Tout
2?
!dropout_1/StatefulPartitionedCallStatefulPartitionedCall6batch_normalization_1/StatefulPartitionedCall:output:0*
Tin
2**
config_proto

CPU

GPU 2J 8*
Tout
2*-
_gradient_op_typePartitionedCall-249797*N
fIRG
E__inference_dropout_1_layer_call_and_return_conditional_losses_249786*(
_output_shapes
:???????????
dense_8/StatefulPartitionedCallStatefulPartitionedCall*dropout_1/StatefulPartitionedCall:output:0&dense_8_statefulpartitionedcall_args_1&dense_8_statefulpartitionedcall_args_2*-
_gradient_op_typePartitionedCall-249827*
Tout
2**
config_proto

CPU

GPU 2J 8*
Tin
2*L
fGRE
C__inference_dense_8_layer_call_and_return_conditional_losses_249821*'
_output_shapes
:??????????
IdentityIdentity(dense_8/StatefulPartitionedCall:output:0.^batch_normalization_1/StatefulPartitionedCall ^dense_5/StatefulPartitionedCall ^dense_6/StatefulPartitionedCall ^dense_7/StatefulPartitionedCall ^dense_8/StatefulPartitionedCall"^dropout_1/StatefulPartitionedCall*'
_output_shapes
:?????????*
T0"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::2B
dense_6/StatefulPartitionedCalldense_6/StatefulPartitionedCall2B
dense_7/StatefulPartitionedCalldense_7/StatefulPartitionedCall2B
dense_8/StatefulPartitionedCalldense_8/StatefulPartitionedCall2^
-batch_normalization_1/StatefulPartitionedCall-batch_normalization_1/StatefulPartitionedCall2F
!dropout_1/StatefulPartitionedCall!dropout_1/StatefulPartitionedCall2B
dense_5/StatefulPartitionedCalldense_5/StatefulPartitionedCall:& "
 
_user_specified_nameinputs: : : : : : : : :	 :
 : : 
?
?
-__inference_sequential_8_layer_call_fn_249946
dense_5_input"
statefulpartitionedcall_args_1"
statefulpartitionedcall_args_2"
statefulpartitionedcall_args_3"
statefulpartitionedcall_args_4"
statefulpartitionedcall_args_5"
statefulpartitionedcall_args_6"
statefulpartitionedcall_args_7"
statefulpartitionedcall_args_8"
statefulpartitionedcall_args_9#
statefulpartitionedcall_args_10#
statefulpartitionedcall_args_11#
statefulpartitionedcall_args_12
identity??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCalldense_5_inputstatefulpartitionedcall_args_1statefulpartitionedcall_args_2statefulpartitionedcall_args_3statefulpartitionedcall_args_4statefulpartitionedcall_args_5statefulpartitionedcall_args_6statefulpartitionedcall_args_7statefulpartitionedcall_args_8statefulpartitionedcall_args_9statefulpartitionedcall_args_10statefulpartitionedcall_args_11statefulpartitionedcall_args_12*'
_output_shapes
:?????????*-
_gradient_op_typePartitionedCall-249931*
Tin
2**
config_proto

CPU

GPU 2J 8*Q
fLRJ
H__inference_sequential_8_layer_call_and_return_conditional_losses_249930*
Tout
2?
IdentityIdentity StatefulPartitionedCall:output:0^StatefulPartitionedCall*
T0*'
_output_shapes
:?????????"
identityIdentity:output:0*W
_input_shapesF
D:??????????p::::::::::::22
StatefulPartitionedCallStatefulPartitionedCall:- )
'
_user_specified_namedense_5_input: : : : : : : : :	 :
 : : "wL
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*?
serving_default?
H
dense_5_input7
serving_default_dense_5_input:0??????????p;
dense_80
StatefulPartitionedCall:0?????????tensorflow/serving/predict*>
__saved_model_init_op%#
__saved_model_init_op

NoOp:??
?0
layer-0
layer_with_weights-0
layer-1
layer_with_weights-1
layer-2
layer_with_weights-2
layer-3
layer_with_weights-3
layer-4
layer-5
layer_with_weights-4
layer-6
	optimizer
	trainable_variables

	variables
regularization_losses
	keras_api

signatures
|__call__
}_default_save_signature
*~&call_and_return_all_conditional_losses"?-
_tf_keras_sequential?,{"class_name": "Sequential", "name": "sequential_8", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "config": {"name": "sequential_8", "layers": [{"class_name": "Dense", "config": {"name": "dense_5", "trainable": true, "batch_input_shape": [null, 14359], "dtype": "float32", "units": 20, "activation": "relu", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}, {"class_name": "Dense", "config": {"name": "dense_6", "trainable": true, "dtype": "float32", "units": 10, "activation": "tanh", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}, {"class_name": "Dense", "config": {"name": "dense_7", "trainable": true, "dtype": "float32", "units": 1024, "activation": "relu", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}, {"class_name": "BatchNormalization", "config": {"name": "batch_normalization_1", "trainable": true, "dtype": "float32", "axis": [1], "momentum": 0.99, "epsilon": 0.001, "center": true, "scale": true, "beta_initializer": {"class_name": "Zeros", "config": {}}, "gamma_initializer": {"class_name": "Ones", "config": {}}, "moving_mean_initializer": {"class_name": "Zeros", "config": {}}, "moving_variance_initializer": {"class_name": "Ones", "config": {}}, "beta_regularizer": null, "gamma_regularizer": null, "beta_constraint": null, "gamma_constraint": null}}, {"class_name": "Dropout", "config": {"name": "dropout_1", "trainable": true, "dtype": "float32", "rate": 0.5, "noise_shape": null, "seed": null}}, {"class_name": "Dense", "config": {"name": "dense_8", "trainable": true, "dtype": "float32", "units": 1, "activation": "sigmoid", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}]}, "input_spec": {"class_name": "InputSpec", "config": {"dtype": null, "shape": null, "ndim": null, "max_ndim": null, "min_ndim": 2, "axes": {"-1": 14359}}}, "keras_version": "2.2.4-tf", "backend": "tensorflow", "model_config": {"class_name": "Sequential", "config": {"name": "sequential_8", "layers": [{"class_name": "Dense", "config": {"name": "dense_5", "trainable": true, "batch_input_shape": [null, 14359], "dtype": "float32", "units": 20, "activation": "relu", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}, {"class_name": "Dense", "config": {"name": "dense_6", "trainable": true, "dtype": "float32", "units": 10, "activation": "tanh", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}, {"class_name": "Dense", "config": {"name": "dense_7", "trainable": true, "dtype": "float32", "units": 1024, "activation": "relu", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}, {"class_name": "BatchNormalization", "config": {"name": "batch_normalization_1", "trainable": true, "dtype": "float32", "axis": [1], "momentum": 0.99, "epsilon": 0.001, "center": true, "scale": true, "beta_initializer": {"class_name": "Zeros", "config": {}}, "gamma_initializer": {"class_name": "Ones", "config": {}}, "moving_mean_initializer": {"class_name": "Zeros", "config": {}}, "moving_variance_initializer": {"class_name": "Ones", "config": {}}, "beta_regularizer": null, "gamma_regularizer": null, "beta_constraint": null, "gamma_constraint": null}}, {"class_name": "Dropout", "config": {"name": "dropout_1", "trainable": true, "dtype": "float32", "rate": 0.5, "noise_shape": null, "seed": null}}, {"class_name": "Dense", "config": {"name": "dense_8", "trainable": true, "dtype": "float32", "units": 1, "activation": "sigmoid", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}}]}}, "training_config": {"loss": "binary_crossentropy", "metrics": ["accuracy"], "weighted_metrics": null, "sample_weight_mode": null, "loss_weights": null, "optimizer_config": {"class_name": "Adam", "config": {"name": "Adam", "learning_rate": 0.0010000000474974513, "decay": 0.0, "beta_1": 0.8999999761581421, "beta_2": 0.9990000128746033, "epsilon": 1e-07, "amsgrad": false}}}}
?
trainable_variables
	variables
regularization_losses
	keras_api
__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "InputLayer", "name": "dense_5_input", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": [null, 14359], "config": {"batch_input_shape": [null, 14359], "dtype": "float32", "sparse": false, "name": "dense_5_input"}}
?

kernel
bias
trainable_variables
	variables
regularization_losses
	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "Dense", "name": "dense_5", "trainable": true, "expects_training_arg": false, "dtype": "float32", "batch_input_shape": [null, 14359], "config": {"name": "dense_5", "trainable": true, "batch_input_shape": [null, 14359], "dtype": "float32", "units": 20, "activation": "relu", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}, "input_spec": {"class_name": "InputSpec", "config": {"dtype": null, "shape": null, "ndim": null, "max_ndim": null, "min_ndim": 2, "axes": {"-1": 14359}}}}
?

kernel
bias
trainable_variables
	variables
regularization_losses
	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "Dense", "name": "dense_6", "trainable": true, "expects_training_arg": false, "dtype": "float32", "batch_input_shape": null, "config": {"name": "dense_6", "trainable": true, "dtype": "float32", "units": 10, "activation": "tanh", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}, "input_spec": {"class_name": "InputSpec", "config": {"dtype": null, "shape": null, "ndim": null, "max_ndim": null, "min_ndim": 2, "axes": {"-1": 20}}}}
?

kernel
bias
 trainable_variables
!	variables
"regularization_losses
#	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "Dense", "name": "dense_7", "trainable": true, "expects_training_arg": false, "dtype": "float32", "batch_input_shape": null, "config": {"name": "dense_7", "trainable": true, "dtype": "float32", "units": 1024, "activation": "relu", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}, "input_spec": {"class_name": "InputSpec", "config": {"dtype": null, "shape": null, "ndim": null, "max_ndim": null, "min_ndim": 2, "axes": {"-1": 10}}}}
?
$axis
	%gamma
&beta
'moving_mean
(moving_variance
)trainable_variables
*	variables
+regularization_losses
,	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "BatchNormalization", "name": "batch_normalization_1", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "config": {"name": "batch_normalization_1", "trainable": true, "dtype": "float32", "axis": [1], "momentum": 0.99, "epsilon": 0.001, "center": true, "scale": true, "beta_initializer": {"class_name": "Zeros", "config": {}}, "gamma_initializer": {"class_name": "Ones", "config": {}}, "moving_mean_initializer": {"class_name": "Zeros", "config": {}}, "moving_variance_initializer": {"class_name": "Ones", "config": {}}, "beta_regularizer": null, "gamma_regularizer": null, "beta_constraint": null, "gamma_constraint": null}, "input_spec": {"class_name": "InputSpec", "config": {"dtype": null, "shape": null, "ndim": 2, "max_ndim": null, "min_ndim": null, "axes": {"1": 1024}}}}
?
-trainable_variables
.	variables
/regularization_losses
0	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "Dropout", "name": "dropout_1", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "config": {"name": "dropout_1", "trainable": true, "dtype": "float32", "rate": 0.5, "noise_shape": null, "seed": null}}
?

1kernel
2bias
3trainable_variables
4	variables
5regularization_losses
6	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "Dense", "name": "dense_8", "trainable": true, "expects_training_arg": false, "dtype": "float32", "batch_input_shape": null, "config": {"name": "dense_8", "trainable": true, "dtype": "float32", "units": 1, "activation": "sigmoid", "use_bias": true, "kernel_initializer": {"class_name": "GlorotUniform", "config": {"seed": null}}, "bias_initializer": {"class_name": "Zeros", "config": {}}, "kernel_regularizer": null, "bias_regularizer": null, "activity_regularizer": null, "kernel_constraint": null, "bias_constraint": null}, "input_spec": {"class_name": "InputSpec", "config": {"dtype": null, "shape": null, "ndim": null, "max_ndim": null, "min_ndim": 2, "axes": {"-1": 1024}}}}
?
7iter

8beta_1

9beta_2
	:decay
;learning_ratemhmimjmkmlmm%mn&mo1mp2mqvrvsvtvuvvvw%vx&vy1vz2v{"
	optimizer
f
0
1
2
3
4
5
%6
&7
18
29"
trackable_list_wrapper
v
0
1
2
3
4
5
%6
&7
'8
(9
110
211"
trackable_list_wrapper
 "
trackable_list_wrapper
?
	trainable_variables

<layers

	variables
regularization_losses
=non_trainable_variables
>metrics
?layer_regularization_losses
|__call__
}_default_save_signature
*~&call_and_return_all_conditional_losses
&~"call_and_return_conditional_losses"
_generic_user_object
-
?serving_default"
signature_map
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
?
trainable_variables

@layers
	variables
Anon_trainable_variables
regularization_losses
Bmetrics
Clayer_regularization_losses
__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
!:	?p2dense_5/kernel
:2dense_5/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
trainable_variables

Dlayers
	variables
Enon_trainable_variables
regularization_losses
Fmetrics
Glayer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
 :
2dense_6/kernel
:
2dense_6/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
trainable_variables

Hlayers
	variables
Inon_trainable_variables
regularization_losses
Jmetrics
Klayer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
!:	
?2dense_7/kernel
:?2dense_7/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
 trainable_variables

Llayers
!	variables
Mnon_trainable_variables
"regularization_losses
Nmetrics
Olayer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
*:(?2batch_normalization_1/gamma
):'?2batch_normalization_1/beta
2:0? (2!batch_normalization_1/moving_mean
6:4? (2%batch_normalization_1/moving_variance
.
%0
&1"
trackable_list_wrapper
<
%0
&1
'2
(3"
trackable_list_wrapper
 "
trackable_list_wrapper
?
)trainable_variables

Players
*	variables
Qnon_trainable_variables
+regularization_losses
Rmetrics
Slayer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
?
-trainable_variables

Tlayers
.	variables
Unon_trainable_variables
/regularization_losses
Vmetrics
Wlayer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
!:	?2dense_8/kernel
:2dense_8/bias
.
10
21"
trackable_list_wrapper
.
10
21"
trackable_list_wrapper
 "
trackable_list_wrapper
?
3trainable_variables

Xlayers
4	variables
Ynon_trainable_variables
5regularization_losses
Zmetrics
[layer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
:	 (2training_1/Adam/iter
 : (2training_1/Adam/beta_1
 : (2training_1/Adam/beta_2
: (2training_1/Adam/decay
':% (2training_1/Adam/learning_rate
J
0
1
2
3
4
5"
trackable_list_wrapper
.
'0
(1"
trackable_list_wrapper
'
\0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
.
'0
(1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
?
	]total
	^count
_
_fn_kwargs
`trainable_variables
a	variables
bregularization_losses
c	keras_api
?__call__
+?&call_and_return_all_conditional_losses"?
_tf_keras_layer?{"class_name": "MeanMetricWrapper", "name": "accuracy", "trainable": true, "expects_training_arg": true, "dtype": "float32", "batch_input_shape": null, "config": {"name": "accuracy", "dtype": "float32"}}
:  (2total
:  (2count
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
.
]0
^1"
trackable_list_wrapper
 "
trackable_list_wrapper
?
`trainable_variables

dlayers
a	variables
enon_trainable_variables
bregularization_losses
fmetrics
glayer_regularization_losses
?__call__
+?&call_and_return_all_conditional_losses
'?"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
.
]0
^1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
1:/	?p2 training_1/Adam/dense_5/kernel/m
*:(2training_1/Adam/dense_5/bias/m
0:.
2 training_1/Adam/dense_6/kernel/m
*:(
2training_1/Adam/dense_6/bias/m
1:/	
?2 training_1/Adam/dense_7/kernel/m
+:)?2training_1/Adam/dense_7/bias/m
::8?2-training_1/Adam/batch_normalization_1/gamma/m
9:7?2,training_1/Adam/batch_normalization_1/beta/m
1:/	?2 training_1/Adam/dense_8/kernel/m
*:(2training_1/Adam/dense_8/bias/m
1:/	?p2 training_1/Adam/dense_5/kernel/v
*:(2training_1/Adam/dense_5/bias/v
0:.
2 training_1/Adam/dense_6/kernel/v
*:(
2training_1/Adam/dense_6/bias/v
1:/	
?2 training_1/Adam/dense_7/kernel/v
+:)?2training_1/Adam/dense_7/bias/v
::8?2-training_1/Adam/batch_normalization_1/gamma/v
9:7?2,training_1/Adam/batch_normalization_1/beta/v
1:/	?2 training_1/Adam/dense_8/kernel/v
*:(2training_1/Adam/dense_8/bias/v
?2?
-__inference_sequential_8_layer_call_fn_249904
-__inference_sequential_8_layer_call_fn_249946
-__inference_sequential_8_layer_call_fn_250180
-__inference_sequential_8_layer_call_fn_250163?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
!__inference__wrapped_model_249499?
???
FullArgSpec
args? 
varargsjargs
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *-?*
(?%
dense_5_input??????????p
?2?
H__inference_sequential_8_layer_call_and_return_conditional_losses_250094
H__inference_sequential_8_layer_call_and_return_conditional_losses_250146
H__inference_sequential_8_layer_call_and_return_conditional_losses_249839
H__inference_sequential_8_layer_call_and_return_conditional_losses_249863?
???
FullArgSpec1
args)?&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults?
p 

 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2??
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkwjkwargs
defaults? 

kwonlyargs?

jtraining%
kwonlydefaults?

trainingp 
annotations? *
 
?2??
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkwjkwargs
defaults? 

kwonlyargs?

jtraining%
kwonlydefaults?

trainingp 
annotations? *
 
?2?
(__inference_dense_5_layer_call_fn_250198?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
C__inference_dense_5_layer_call_and_return_conditional_losses_250191?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
(__inference_dense_6_layer_call_fn_250216?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
C__inference_dense_6_layer_call_and_return_conditional_losses_250209?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
(__inference_dense_7_layer_call_fn_250234?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
C__inference_dense_7_layer_call_and_return_conditional_losses_250227?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
6__inference_batch_normalization_1_layer_call_fn_250354
6__inference_batch_normalization_1_layer_call_fn_250345?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_250313
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_250336?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
*__inference_dropout_1_layer_call_fn_250384
*__inference_dropout_1_layer_call_fn_250389?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
E__inference_dropout_1_layer_call_and_return_conditional_losses_250374
E__inference_dropout_1_layer_call_and_return_conditional_losses_250379?
???
FullArgSpec)
args!?
jself
jinputs

jtraining
varargs
 
varkw
 
defaults?
p 

kwonlyargs? 
kwonlydefaults? 
annotations? *
 
?2?
(__inference_dense_8_layer_call_fn_250407?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
?2?
C__inference_dense_8_layer_call_and_return_conditional_losses_250400?
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 
9B7
$__inference_signature_wrapper_250007dense_5_input
?2??
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkwjkwargs
defaults? 

kwonlyargs?

jtraining%
kwonlydefaults?

trainingp 
annotations? *
 
?2??
???
FullArgSpec
args?
jself
jinputs
varargs
 
varkwjkwargs
defaults? 

kwonlyargs?

jtraining%
kwonlydefaults?

trainingp 
annotations? *
 ?
-__inference_sequential_8_layer_call_fn_250163b'(%&128?5
.?+
!?
inputs??????????p
p

 
? "???????????
H__inference_sequential_8_layer_call_and_return_conditional_losses_249863v(%'&12??<
5?2
(?%
dense_5_input??????????p
p 

 
? "%?"
?
0?????????
? ?
6__inference_batch_normalization_1_layer_call_fn_250354W(%'&4?1
*?'
!?
inputs??????????
p 
? "????????????
C__inference_dense_6_layer_call_and_return_conditional_losses_250209\/?,
%?"
 ?
inputs?????????
? "%?"
?
0?????????

? ?
C__inference_dense_5_layer_call_and_return_conditional_losses_250191]0?-
&?#
!?
inputs??????????p
? "%?"
?
0?????????
? ?
!__inference__wrapped_model_249499z(%'&127?4
-?*
(?%
dense_5_input??????????p
? "1?.
,
dense_8!?
dense_8?????????
*__inference_dropout_1_layer_call_fn_250384Q4?1
*?'
!?
inputs??????????
p
? "????????????
H__inference_sequential_8_layer_call_and_return_conditional_losses_249839v'(%&12??<
5?2
(?%
dense_5_input??????????p
p

 
? "%?"
?
0?????????
? |
(__inference_dense_7_layer_call_fn_250234P/?,
%?"
 ?
inputs?????????

? "????????????
E__inference_dropout_1_layer_call_and_return_conditional_losses_250379^4?1
*?'
!?
inputs??????????
p 
? "&?#
?
0??????????
? ?
E__inference_dropout_1_layer_call_and_return_conditional_losses_250374^4?1
*?'
!?
inputs??????????
p
? "&?#
?
0??????????
? ?
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_250313d'(%&4?1
*?'
!?
inputs??????????
p
? "&?#
?
0??????????
? ?
6__inference_batch_normalization_1_layer_call_fn_250345W'(%&4?1
*?'
!?
inputs??????????
p
? "???????????|
(__inference_dense_5_layer_call_fn_250198P0?-
&?#
!?
inputs??????????p
? "???????????
-__inference_sequential_8_layer_call_fn_249946i(%'&12??<
5?2
(?%
dense_5_input??????????p
p 

 
? "???????????
-__inference_sequential_8_layer_call_fn_250180b(%'&128?5
.?+
!?
inputs??????????p
p 

 
? "??????????
*__inference_dropout_1_layer_call_fn_250389Q4?1
*?'
!?
inputs??????????
p 
? "????????????
$__inference_signature_wrapper_250007?(%'&12H?E
? 
>?;
9
dense_5_input(?%
dense_5_input??????????p"1?.
,
dense_8!?
dense_8??????????
C__inference_dense_7_layer_call_and_return_conditional_losses_250227]/?,
%?"
 ?
inputs?????????

? "&?#
?
0??????????
? ?
C__inference_dense_8_layer_call_and_return_conditional_losses_250400]120?-
&?#
!?
inputs??????????
? "%?"
?
0?????????
? ?
H__inference_sequential_8_layer_call_and_return_conditional_losses_250146o(%'&128?5
.?+
!?
inputs??????????p
p 

 
? "%?"
?
0?????????
? ?
-__inference_sequential_8_layer_call_fn_249904i'(%&12??<
5?2
(?%
dense_5_input??????????p
p

 
? "???????????
H__inference_sequential_8_layer_call_and_return_conditional_losses_250094o'(%&128?5
.?+
!?
inputs??????????p
p

 
? "%?"
?
0?????????
? {
(__inference_dense_6_layer_call_fn_250216O/?,
%?"
 ?
inputs?????????
? "??????????
|
(__inference_dense_8_layer_call_fn_250407P120?-
&?#
!?
inputs??????????
? "???????????
Q__inference_batch_normalization_1_layer_call_and_return_conditional_losses_250336d(%'&4?1
*?'
!?
inputs??????????
p 
? "&?#
?
0??????????
? 