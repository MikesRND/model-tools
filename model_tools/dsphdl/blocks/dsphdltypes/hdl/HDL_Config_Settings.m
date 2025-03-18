%% Set Model 'hdlconvert_tb' HDL parameters
hdlset_param('hdlconvert_tb', 'DateComment', 'off');
hdlset_param('hdlconvert_tb', 'EntityConflictPostfix', '_b');
hdlset_param('hdlconvert_tb', 'HDLCompileTerm', 'quit -f');
hdlset_param('hdlconvert_tb', 'HDLSimTerm', ['run -all\n',char(10),...
'quit -f']);
hdlset_param('hdlconvert_tb', 'HDLSubsystem', 'hdlconvert_tb/hdlconvert_demo');
hdlset_param('hdlconvert_tb', 'HDLSynthTool', 'Quartus');
hdlset_param('hdlconvert_tb', 'InlineMATLABBlockCode', 'on');
hdlset_param('hdlconvert_tb', 'MinimizeClockEnables', 'on');
hdlset_param('hdlconvert_tb', 'MinimizeIntermediateSignals', 'on');
hdlset_param('hdlconvert_tb', 'OptimizationReport', 'on');
hdlset_param('hdlconvert_tb', 'ResourceReport', 'on');
hdlset_param('hdlconvert_tb', 'SynthesisTool', 'Altera QUARTUS II');
hdlset_param('hdlconvert_tb', 'SynthesisToolChipFamily', 'Stratix V');
hdlset_param('hdlconvert_tb', 'SynthesisToolDeviceName', '5SGSMD8N2F45I2');
hdlset_param('hdlconvert_tb', 'TargetDirectory', '../hdl');
hdlset_param('hdlconvert_tb', 'Traceability', 'on');
hdlset_param('hdlconvert_tb', 'UserComment', 'Copyright 2016 Viasat.\nAuthor: mike babst <mikebabst@gmail.com>');

