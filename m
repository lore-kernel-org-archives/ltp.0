From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Mar 2016 10:27:36 +0100
Subject: [LTP] poll02 threshold overruns
In-Reply-To: <SN1PR12MB07827ABE2B50365F2C528A03EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>
References: <SN1PR12MB07827ABE2B50365F2C528A03EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>
Message-ID: <20160322092735.GA9410@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm working on PowerPc based board MPC8360 and we are running 4.1.13 kernel. During our LTP run, we saw the following failure with poll02 test.
> 
> poll02      1  TFAIL  :  poll02.c:92: poll() slept too long 115ms, expected 100ms, threshold 12
> 
> The log file is attached to this mail.
> 
> Please note that I'm running the latest LTP code.
> 
> I understand that threshold value overruns the relax limit. I try changing the threshold value to 20 as below (to give more relaxing time)
> 
> testcases/kernel/syscalls/poll/poll02.c, line 61
> 
> - treshold = sleep_ms / 100 + 10;
> +treshold = sleep_ms / 10 + 10;
> 
> I ran the test in a loop until it fails and the test failed after 3 mins at attempt number 240 with the timer value 121ms. Error as below:
> 
> poll02      1  TFAIL  :  poll02.c:92: poll() slept too long 121ms, expected 100ms, threshold 20
> 
> 
> Can you please look into this and explain the behaviour and a possible solution? Is it a architecture constraint?

The thresholds were set up by trial and error on older PC. The timer
overruns have no real upper cap and they depends on CPU speed, kernel
.config parameters and system load.

So it possibly may fail on slow embedded machines. I guess that what we
should do is to move the treshold computation into the test library so
that we can tweak the value in one place and either do some heuristic or
provide a way to override it by user.

-- 
Cyril Hrubis
chrubis@suse.cz
