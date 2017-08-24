From: fixed-term.Islam.Tammam <fixed-term.Islam.Tammam@de.bosch.com>
Date: Thu, 24 Aug 2017 09:32:52 +0200
Subject: [LTP] Test case float_trigo Reading dsin error
In-Reply-To: <20170822145003.GA26138@rei.lan>
References: <9b9cf670-cc80-1083-3401-c2191d227f5b@de.bosch.com>
 <20170822145003.GA26138@rei.lan>
Message-ID: <0cca61a2-68a6-72e6-70af-ac437b6e0500@de.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
what is the format of dsin and dtan files ? i.e how do they look like 
since they are binaries i have no clue for creating them.

i just had a look at the link here
https://github.com/linux-test-project/ltp/tree/master/testcases/misc/math/float/trigo

to be able to generate the data files "manually" , but such data files 
shall be generated automatically when running the ./float_trigo test 
cases itself. do you have an idea how so that happens ? and what is the 
destination directory of the generated files , since i checked 
/opt/ltp/testcases/bin but didn't find any data files generated there.



Best regards,

*Islam Tammam
Test Architect and Team Leader
CM/ESO3*

Tel.  +49(5121)49-5911


On 08/22/2017 04:50 PM, Cyril Hrubis wrote:
> Hi!
>> I have faced recently an issue with an imx6 target which is running
>> kernel version "3.14" for the below tests:
>>
>> float_bessel
>> float_exp_log
>> float_power
>> float_trigo
>>
>> these tests are failing and giving an error of thread termination "No
>> such file or directory". Please find a log below. any reason why that
>> happened and how can this be solved ?
>>
>> target:/opt/ltp/testcases/bin# ./float_trigo
>> float_trigo 1 TPASS : Test passed
>> float_trigo 1 TFAIL : main.c:292: thread 100 (sin) terminated
>> unsuccessfully 0 errors/0 loops
>> FAIL: sin: reading dsin, No such file or directory
>> float_trigo 2 TFAIL : main.c:292: thread 101 (sin) terminated
>> unsuccessfully 0 errors/0 loops
>> FAIL: sin: reading dsin, No such file or directory
>> float_trigo 3 TFAIL : main.c:292: thread 102 (sin) terminated
>> unsuccessfully 0 errors/0 loops
>> FAIL: sin: reading dsin, No such file or directory
>> float_trigo 4 TFAIL : main.c:292: thread 103 (sin) terminated
>> unsuccessfully 0 errors/0 loops
>> FAIL: sin: reading dsin, No such file or directory
>> ....
>> ....
>> ....
>> float_trigo 40 TFAIL : main.c:292: thread 139 (tan) terminated
>> unsuccessfully 0 errors/0 loops
>> FAIL: tan: reading dtan, No such file or directory
>> float_trigo 41 TFAIL : main.c:41: Test failed
>>
>> I have no idea why the generation of files such asin, atan, acos works
>> but doesn't work for dsin and dtan ?
>
> Looks like it starts to fail in the middle of the test, that is really
> strange. Have you checked that gensin and gentan binaries are working
> fine (create non-empty rsin and dsin as well as rtan and dtan
> files)?
>
