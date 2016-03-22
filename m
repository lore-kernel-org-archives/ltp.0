From: Kshitij Malik <Kshitij.Malik@mitel.com>
Date: Tue, 22 Mar 2016 14:28:52 +0000
Subject: [LTP] poll02 threshold overruns
In-Reply-To: <20160322092735.GA9410@rei.lan>
References: <SN1PR12MB07827ABE2B50365F2C528A03EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>,
 <20160322092735.GA9410@rei.lan>
Message-ID: <SN1PR12MB07827F3598E13F4E6F9E9401EE800@SN1PR12MB0782.namprd12.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you Cyril for the reply.

What kernel configurations are we talking about here?

Is there a formula to calculate threshold based on CPU speed and kernel parameters?

Thanks
KK
________________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Tuesday, March 22, 2016 05:27
To: Kshitij Malik
Cc: ltp@lists.linux.it
Subject: Re: poll02 threshold overruns

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
________________________________
NOTE: This e-mail (including any attachments) is for the sole use of the intended recipient(s) and may contain information that is confidential and/or protected by legal privilege. Any unauthorized review, use, copy, disclosure or distribution of this e-mail is strictly prohibited. If you are not the intended recipient, please notify Mitel immediately and destroy all copies of this e-mail. Mitel does not accept any liability for breach of security, error or virus that may result from the transmission of this message.
