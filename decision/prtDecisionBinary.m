classdef prtDecisionBinary < prtDecision
    % prtDecisionBinary Base class for all prtDecisionBinary objects
    %
    % A prtDecisionBinary object is an abstract class and cannot be
    % instantiated.    
    %
    % prtBinaryDecsion objects find a threshold value that is used to make
    % decisions based on certain criteria.
    %
    % prtDecisionBinary objects all have the following function:
    %
    % getThreshold - return the prtDecisionBinary objects decision
    %                threshold
    %
    % See also: prtDecisionBinaryMinPe, prtDecisionBinarySpecifiedPd,
    % ptDecisionBinarySpecifiedPf, prtDecisionMap
    
    methods (Abstract)
        threshold = getThreshold(Obj) 
        % THRESH = getThreshold returns the objects threshold
    end
    methods
        function obj = prtDecisionBinary()
            obj.classInput = 'prtDataSetClass';
            obj.classOutput = 'prtDataSetClass';
            
            obj.isSupervised = true;
        end
    end
    
    methods (Access=protected,Hidden=true)
        function DS = runAction(Obj,DS)
            theClasses = Obj.classList;
            DS = DS.setObservations(theClasses((DS.getObservations >= Obj.getThreshold) + 1));
        end
    end
    
    methods (Access = protected, Hidden = true)
        function ClassObj = preTrainProcessing(ClassObj, DataSet)
            % Overload preTrainProcessing() so that we can determine mary
            % output status
            assert(DataSet.isLabeled & DataSet.nClasses > 1,'The prtDataSetClass input to the train() method of a prtDecisionBinary must have non-empty targets and have more than one class.');
            
            ClassObj = preTrainProcessing@prtAction(ClassObj,DataSet);
        end
    end
    
end