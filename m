From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Wed, 23 Mar 2016 02:39:47 +0000
Subject: [LTP] readahead02 failure on PPC
In-Reply-To: <E2874C5F-277A-4344-8B0D-997C64777F64@smartmatic.com>
References: <SN1PR12MB078260DD2BC3C2091E1D9893EE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
 <1136739411.10804114.1458249456113.JavaMail.zimbra@redhat.com>
 <SN1PR12MB0782C6FC545C11345F3A0B5EEE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
 <33749902.10876382.1458290572208.JavaMail.zimbra@redhat.com>
 <SN1PR12MB07825E24290A308685A01C08EE8F0@SN1PR12MB0782.namprd12.prod.outlook.com>,
 <291167612.12921272.1458640194756.JavaMail.zimbra@redhat.com>
 <E2874C5F-277A-4344-8B0D-997C64777F64@smartmatic.com>
Message-ID: <95d602d5-2cb2-443f-aebc-82396cac1450@hyperion.ve.sbp.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan, Kshitij,

Checking my logs (imx6 32bits based platform) the error is similar [1]:

readahead02 0 TWARN : readahead02.c:324: using less cache than expected

However, the results were not consistent, because, once time PASS and another FAIL (with previous TWARN).

Another thing different was (in my case):

readahead02 3 TCONF : readahead02.c:309: Your system doesn't have /proc/pid/io, unable to determine read bytes during test

This last one, is the part 1 of the test case (read bytes during test). The part 2 (verify the cache) is the same TWARN.

At the end, I skipped this test case because the results were not consistent and need further analysis.

Regards,
Julio


[1] logs for imx6: https://justpaste.it/s4zk

-----Original Message-----
From: ltp [mailto:ltp-bounces+julio.cruz=smartmatic.com@lists.linux.it] On Behalf Of Julio Cruz Barroso
Sent: Tuesday, March 22, 2016 11:19 PM
To: Jan Stancek
Cc: Julio Cruz; Kshitij Malik; ltp@lists.linux.it
Subject: Re: [LTP] readahead02 failure on PPC

Hi Jan, Kshitij,

I just saw this email! 

I will review the issue because I cannot remember the result details and let you know tomorrow (CST).

I expect also to upload the others patchs reviewed.

Regards

Julio


> On Mar 22, 2016, at 5:50 PM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> Kshitij

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
