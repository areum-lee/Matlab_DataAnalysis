clear
clc
close all



%엑셀에서 받기
[~,originxlsx] = xlsread('C:\Users\AREUM\Desktop\python\new\1_origin.xlsx',1);
%엑셀에서 받기

originxlsx2 = xlsread('C:\Users\AREUM\Desktop\python\new\1_origin.xlsx',1);


%엑셀에서 받기
[~,targetxlsx] = xlsread('C:\Users\AREUM\Desktop\python\new\2_c.xlsx',1);
%엑셀에서 받기

targetxlsx2 = xlsread('C:\Users\AREUM\Desktop\python\new\2_c.xlsx',1);
rr=1;
total_cnt=0;
while 1
    if rr == size(originxlsx2,1)
        break;
    else
        patient=originxlsx2(rr,1)
        %중복환자 체크
        [i,j]=find(originxlsx2==patient);
        
        rr=rr+size(i,1);
        
        if size(i,1)==1
            [originxlsx{i(1)+1,17}]=deal('true');
            % 1개일때 셀 안에 true 넣기  data_cell(i(1)+1, 17)='true'
        else
            %여러개일때
            % 날짜
            data_cell=[];
            for k=1:size(i,1)
                a = originxlsx(i(k)+1,6);
                [dd,ddd]=strtok(a,' ');
                data=dd{1};
                year = str2num(data(1:4));
                month = str2num(data(6:7));
                day = str2num(data(9:10));
                data_cell(1,k)=year;
                data_cell(2,k)=month;
                data_cell(3,k)=day;
                
            end

            for k=1:size(i,1)
                for j=1:size(i,1)
                    new=[data_cell(:,1)==data_cell(:,2)]; 
                    if(new(1)==1 && new(2)==1 && new(3)==1)
                       %날짜같은 것. 
                       [originxlsx{i(k)+1,18}]=deal('date_same');
                       [originxlsx{i(j)+1,18}]=deal('date_same');
                    end
                end
            end
                
                
            [t,u]=find(targetxlsx2==patient);
            
            new_q=0;
            for bb = 1:size(t,1)
                
                
                
                
                a = targetxlsx(t(bb)+1,6);
                [dd,ddd]=strtok(a,' ');
                data=dd{1};
                year = str2num(data(1:4))
                month = str2num(data(6:7))
                day = str2num(data(9:10))
                
                cnt=0;
                
                diff_cnt=0;
                day_cnt=0;
                for q=1:size(i,1)
                    if (year == data_cell(1,q) && month == data_cell(2,q) && day==data_cell(3,q))
                        fprintf('6\n');
                        new_q=q;
                        break;
                    elseif (year == data_cell(1,q))
                        if (month == data_cell(2,q))
                            fprintf('1\n');
                            if (day==data_cell(3,q))
                                fprintf('6\n');
                                new_q=q;
           
                            elseif (abs(day-data_cell(3,q)) <=3)
                                
                                fprintf('2\n');
                                % 셀 안에 true 넣기  data_cell(i(q)+1, 17)
                                if day_cnt==0
                                    min_day=abs(day-data_cell(3,q));
                                    new_q=q;
                                    day_cnt=day_cnt+1;
                                else
                                    if min_day <= abs(day-data_cell(3,q))
                                        min_day = min_day;
                                        new_q=q;
                                        
                                    else min_day > abs(day-data_cell(3,q))
                                        min_day=abs(day-data_cell(3,q));
                                        new_q=q;
                                        
                                    end
                                    day_cnt=day_cnt+1;
                                end
        
                            else
                                fprintf('3\n');

                                
                            end
                            
                            
                        elseif (abs(month-data_cell(2,q))==1 && (day <4 && data_cell(3,q) > 27)) || (abs(month-data_cell(2,q))==1 && (day >27 && data_cell(3,q) <4))
                            fprintf('5\n');
                            
                            
                            if (day <4 && data_cell(3,q) > 27)
                                if day<4
                                    switch month-1
                                        case {01,03,05,07,08,10,12}
                                            mdays=31;
                                        case {04,06,09,11}
                                            mdays=30;
                                        case 02
                                            mdays = 28;
                                    end
                                    
                                    tmp_day=mdays*1+day;
                                    if (abs(day-tmp_day) <=3)
                                        % 셀 안에 true 넣기  data_cell(i(q)+1, 17)
                                        if cnt==0
                                            min_day=abs(day-tmp_day);
                                            new_q=q;
                                            cnt=cnt+1;
                                        else
                                            if min_day <= abs(day-tmp_day)
                                                min_day = min_day;
                                                new_q=q;
                                            else min_day > abs(day-tmp_day)
                                                min_day=abs(day-tmp_day);
                                                new_q=q;
                                                
                                            end
                                            cnt=cnt+1;
                                        end
                                    end
                                end
                                
                                
                                
                            elseif (day >27 && data_cell(3,q) <4)
                                
                                if data_cell(3,q)<4
                                    switch data_cell(2,q)-1
                                        case {01,03,05,07,08,10,12}
                                            mdays=31;
                                        case {04,06,09,11}
                                            mdays=30;
                                        case 02
                                            mdays = 28;
                                    end
                                    
                                    tmp_day=mdays*1+data_cell(3,q);
                                    if (abs(data_cell(3,q)-tmp_day) <=3)
                                        % 셀 안에 true 넣기  data_cell(i(q)+1, 17)
                                        if cnt==0
                                            min_day=abs(data_cell(3,q)-tmp_day);
                                            new_q=q;
                                            cnt=cnt+1;
                                        else
                                            if min_day <= abs(data_cell(3,q)-tmp_day)
                                                min_day = min_day;
                                                new_q=q;
                                            else min_day > abs(data_cell(3,q)-tmp_day)
                                                min_day=abs(data_cell(3,q)-tmp_day);
                                                new_q=q;
                                                
                                            end
                                            cnt=cnt+1;
                                        end
                                    end
                                    
                                end
                                
                            else
                                fprintf('14\n');
                                
                                if diff_cnt==0
                                    min_month= abs(month-data_cell(2,q));
                                    new_q=q;
                                    
                                    diff_cnt=diff_cnt+1;
                                else
                                    if min_month <=abs(month-data_cell(2,q))
                                        min_month=min_month;
                                        new_q=q;
                                    else
                                        min_month=abs(month-data_cell(2,q));
                                        new_q=q;
                                    end
                                    diff_cnt=diff_cnt+1;
                                end
                                
                            end
                            
                        end
                        
                    else
                        continue;
                    end %month
                end
                
                %             if total_cnt==0
                %                 total_min=new_q;
                %                 total_q=new_q;
                %                 total_cnt=total_cnt+1;
                %             else
                %                 if total_min <= new_q
                %                     total_q=total_min;
                %                 else
                %                     total_q=new_q;
                %                 end
                %                 total_cnt=total_cnt+1;
                %             end

            end
            if (new_q==0)
                for hh = 1:size(i,1)
                    [originxlsx{i(hh)+1,17}]=deal('100');
                    total_cnt=total_cnt+1;
                end
            else
                [originxlsx{i(new_q)+1,17}]=deal('true');
            end           
            
        end
    end
    
end






