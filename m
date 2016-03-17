From: Kshitij Malik <Kshitij.Malik@mitel.com>
Date: Thu, 17 Mar 2016 19:57:15 +0000
Subject: [LTP] readahead02 failure on PPC
In-Reply-To: <SN1PR12MB078260DD2BC3C2091E1D9893EE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
References: <SN1PR12MB078260DD2BC3C2091E1D9893EE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
Message-ID: <SN1PR12MB0782B14311655329951EC6D5EE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


copying Jan..

________________________________
From: Kshitij Malik
Sent: Thursday, March 17, 2016 13:40
To: ltp@lists.linux.it
Subject: readahead02 failure on PPC


Hi,


I'm working on PowerPc based board MPC8360 and we are running 4.1.13 kernel. During our LTP run, we saw the following failure with readahead02 test.


readahead02    0  TWARN  :  readahead02.c:353: using less cache than expected


The log file is attached to this mail.


Please note that I'm running the latest LTP code and has the latest readahead02.c patch checked in yesterday.


Can you please help me in finding out the solution for this issue?


Please let me know if you need any other information.


Thanks

KK

________________________________
NOTE: This e-mail (including any attachments) is for the sole use of the intended recipient(s) and may contain information that is confidential and/or protected by legal privilege. Any unauthorized review, use, copy, disclosure or distribution of this e-mail is strictly prohibited. If you are not the intended recipient, please notify Mitel immediately and destroy all copies of this e-mail. Mitel does not accept any liability for breach of security, error or virus that may result from the transmission of this message.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160317/83320c12/attachment.html>
