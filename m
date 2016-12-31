From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Date: Sat, 31 Dec 2016 13:55:50 -0500
Subject: [LTP] On the performance of lcov...
In-Reply-To: <02d71729-2501-cabf-fed0-6f4cc716f565@giref.ulaval.ca>
References: <11e74d02-aec3-04c2-a001-39966d8d3430@giref.ulaval.ca>
 <650748346.6300043.1482001595688.JavaMail.zimbra@redhat.com>
 <a72c1e6a-f963-9eed-ad70-43f1879c43f3@giref.ulaval.ca>
 <02d71729-2501-cabf-fed0-6f4cc716f565@giref.ulaval.ca>
Message-ID: <6f15fdd5-8b83-e5b2-11b5-82fd4e291759@giref.ulaval.ca>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

I have a doubt:

Am I posting to the right list to discuss about lcov performance?

Thanks,

Eric



Le 2016-12-19 à 14:07, Eric Chamberland a écrit :
> Hi,
>
> As suggested, I introduced:
> cat ~/.lcovrc
> geninfo_gcov_all_blocks=0
>
> Now the timings for each steps (see 1st mail) are:
>
> Now    ; Before
> ================
> 600s   ; 660s
> 1269s  ; 2113s
> 2815s  ; 3112s
> 2305s  ; 2227s
> 1401s  ; 1391s
> ================
> total:
> 8390s ; 9503s
>
> So there is a good gain in the 2nd step, but overall, no big changes...
>
> I am using
> gcov -v
> gcov (SUSE Linux) 4.8.1 20130909 [gcc-4_8-branch revision 202388]
>
> lcov -v
> lcov: LCOV version 1.12
>
> Are there any other hints or is it "normal" to have these timings?
>
> Is there someone who tried to optimise gcov or lcov?
>
> Will I see a significant gain if I upgrade to a newer version of the 
> compiler?
>
> Thanks,
>
> Eric
>
> On 17/12/16 04:29 PM, Eric Chamberland wrote:
>> Good, I modified the ~/.lcovrc file and I will report the new timings
>> tomorrow.
>>
>> Thanks! :)
>>
>> Eric
>>
>> Le 2016-12-17 à 14:06, Jan Stancek a écrit :
>>>
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Eric Chamberland" <Eric.Chamberland@giref.ulaval.ca>
>>>> To: ltp@lists.linux.it
>>>> Sent: Saturday, 17 December, 2016 7:56:17 PM
>>>> Subject: [LTP] On the performance of lcov...
>>>>
>>>> Hi,
>>>>
>>>> We are running gcov+lcov analysis each night for our software.  It 
>>>> does
>>>> a really great job to help us manage our nightly tests database (~1100
>>>> runs) and to discover unused lines of code! :)
>>>>
>>>> However running lcov+genthml is really time consuming (longer than the
>>>> tests or even compiling the code) and I would like to know if there 
>>>> is a
>>>> way to make lcov+genthml go a little faster...
>>>>
>>>> Here is the timings for a complete analysis and html generation:
>>>>
>>>> ===========================
>>>>    660s (1866 .gcno files):  lcov --rc lcov_branch_coverage=1 
>>>> --capture
>>>> --initial -d $obj/dev -d $obj2/dev -o init.info
>>>>
>>>> 2113s (1662 .gcda files): lcov --rc lcov_branch_coverage=1 
>>>> --capture -d
>>>> $obj/dev -d $obj2/dev -o cov.info
>>>>
>>>> 3112s: lcov --rc lcov_branch_coverage=1 --remove init.info "/usr*"
>>>> "/opt*" "/pmi/Indus*" -o init.info && lcov --rc lcov_branch_coverage=1
>>>> --remove cov.info   "/usr*" "/opt*" "/pmi/Indus*" -o cov.info
>>>> ...
>>>> Deleted 255 files
>>>> Writing data to cov.info
>>>> Summary coverage rate:
>>>>     lines......: 69.4% (357216 of 515067 lines)
>>>>     functions..: 64.1% (61500 of 95942 functions)
>>>>     branches...: 32.1% (717338 of 2232711 branches)
>>>>
>>>> 2227s:  lcov --rc lcov_branch_coverage=1 -a init.info -a cov.info -o
>>>> total.info
>>>> ...
>>>> Combining tracefiles.
>>>> Reading tracefile init.info
>>>> Reading tracefile cov.info
>>>> Writing data to total.info
>>>> Summary coverage rate:
>>>>     lines......: 64.5% (357216 of 553958 lines)
>>>>     functions..: 60.3% (61500 of 102006 functions)
>>>>     branches...: 32.1% (717338 of 2232711 branches)
>>>>
>>>> 1391s:  genhtml  --show-details --legend --branch-coverage
>>>> --demangle-cpp -o $$pref_html/coverage_dev total.info
>>>> Reading data file total.info
>>>> Found 2854 entries.
>>>> ...
>>>> ===========================
>>>>
>>>> total time: 9503s => 2h38m
>>>>
>>>> We would like to understand if we are doing something wrong... or if
>>>> someone is aware of this performance "problem" or willing to optimize
>>>> lcov/genthml code itself?
>>> Hi,
>>>
>>> 2 bugs below come to mind, try turning off --all-blocks to see if 
>>> this is
>>> your case as well. There should an option for that in lcov config file.
>>>
>>> Bug 1290759 - gcov takes up to 36hours to process xfs_sb.gcda on Intel
>>> Xeon
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1290759
>>>
>>> Bug 67992 - GCOV takes an absurdly long time to process a file
>>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67992
>>>
>>> Regards,
>>> Jan
>>>
>>>> anyway, thanks for this great tool! :)
>>>>
>>>> Eric
>>>>
>>>>
>>>> -- 
>>>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>>>
>>
>>
>

