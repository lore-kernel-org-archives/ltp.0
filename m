From: Kshitij Malik <Kshitij.Malik@mitel.com>
Date: Mon, 21 Mar 2016 21:23:43 +0000
Subject: [LTP] poll02 threshold overruns
Message-ID: <SN1PR12MB07827ABE2B50365F2C528A03EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm working on PowerPc based board MPC8360 and we are running 4.1.13 kernel. During our LTP run, we saw the following failure with poll02 test.

poll02      1  TFAIL  :  poll02.c:92: poll() slept too long 115ms, expected 100ms, threshold 12

The log file is attached to this mail.

Please note that I'm running the latest LTP code.

I understand that threshold value overruns the relax limit. I try changing the threshold value to 20 as below (to give more relaxing time)

testcases/kernel/syscalls/poll/poll02.c, line 61

- treshold = sleep_ms / 100 + 10;
+treshold = sleep_ms / 10 + 10;

I ran the test in a loop until it fails and the test failed after 3 mins at attempt number 240 with the timer value 121ms. Error as below:

poll02      1  TFAIL  :  poll02.c:92: poll() slept too long 121ms, expected 100ms, threshold 20


Can you please look into this and explain the behaviour and a possible solution? Is it a architecture constraint?

Please let me know if you need any other information.

Thanks
KK
________________________________
NOTE: This e-mail (including any attachments) is for the sole use of the intended recipient(s) and may contain information that is confidential and/or protected by legal privilege. Any unauthorized review, use, copy, disclosure or distribution of this e-mail is strictly prohibited. If you are not the intended recipient, please notify Mitel immediately and destroy all copies of this e-mail. Mitel does not accept any liability for breach of security, error or virus that may result from the transmission of this message.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: Ltp_console_output_poll02.log
Type: application/octet-stream
Size: 2709 bytes
Desc: Ltp_console_output_poll02.log
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160321/6ae4596f/attachment-0001.obj>
