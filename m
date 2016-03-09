From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Wed, 9 Mar 2016 10:40:59 +0000
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

I’m trying to perform a testing based on LTP version 20150420 on a Linux 3.14.61 (using iMX6 SOC series).

Basically, I perform the same test in four (4) different SOC (Solo, DualLite, Dual and Quad) including different RAM (512, 512, 1024, 2048MB respectively). The same kernel (with different Device Tree) is used on the four boards.

The test is run as below:

------------------
hostname emad-machine ; 
cd /opt/ltp ; 
rm -r tmp ; 
mkdir tmp ; 
chmod 777 tmp ; 
rm -r results ; 
rm result.fulllog ; 
rm -r output ; 
./runltp -p -l result.log -C result.fail -d /opt/ltp/tmp -g results.html -o result.fulllog
------------------

The results show around 66 test cases fail from a total of 1519. I focused on the fails trying to:

------------------
1) Change the kernel configuration (rebuild) to include any missing option
2) Review the test cases code and try to figure out any false negative
------------------

After perform this analysis, 63 test cases were mark as false negatives, but 4 test cases have unknown conclusion, as show below:

------------------
1. perf_event_open01 failed with < TEST_ERRNO=EOPNOTSUPP(95): Operation not supported. >
   a. I assume the test fail because the HW doesn’t support it. Could be wrong? [more details, please refer to https://justpaste.it/s315]
2. perf_event_open02 cause < WARNING: CPU: 2 PID: 24@kernel/events/core.c:764 perf_cpu_hrtimer_handler+0x1f0/0x20c() >. This warning pass multiples times until /dev/kmsg buffer overrun [more details, please refer to https://justpaste.it/s315]
   a. This test fail because the 01 test already fail, or can I run both independently?
   b. Any advice about the WARNING?  
3. Cap_bounds fail with “cap_bounds_r.c:55: prctl(PR_CAPBSET_READ, 37) returned -1”. The numerical value of the highest capability supported by the running kernel is 36 [cat /proc/sys/kernel/cap_last_cap, http://man7.org/linux/man-pages/man7/capabilities.7.html]. 
   a. Can I assume this as a false negative?
4. su01 fail with < /bin/su -l root with correct password ( FAILED ) > [more details, please refer to https://justpaste.it/s329]. 
   a. Could be an test issue?
------------------

The whole analysis can be refer on https://justpaste.it/s32h. 

Appreciate any suggestion or feedback. I just started using LTP some days ago, please, forgive any huge mistake ☺

Thanks, Julio



