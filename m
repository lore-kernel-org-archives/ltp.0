From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Wed, 23 Mar 2016 04:37:42 +0000
Subject: [LTP] [PATCH] Change memory units to MB to support embedded
	devices
In-Reply-To: <1059278052.10541669.1458207337814.JavaMail.zimbra@redhat.com>
References: <1458097251-2708-1-git-send-email-jcsistemas2001@gmail.com>
 <1059278052.10541669.1458207337814.JavaMail.zimbra@redhat.com>
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA3F87A2@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > to "mtest06_2 mmap2 -x 0.002 -a -p -s 100"
> 
> I think we can make default a smaller value without any impact on what this
> test is doing. Test doesn't say why 1GB was chosen.
> 
> I'd go with 128M, that still covers most scenarios where we'd use at least 2
> consecutive huge pages (of most common sizes).
> 

Done, thanks for the suggestion. Tested on iMX6-DualLite with 512MB:

---------
root@emad:/opt/ltp/testcases/bin# ./mmap2
MM Stress test, map/write/unmap large file
        Test scheduled to run for:       24.000000
        Size of temp file in MB:         128
Available memory: 301MB
creating tmp file and writing 'a' to it created file of size 134217728
content of the file is 'a'
file mapped at 0x6efd2000
changing file content to 'A'
unmapped file at 0x6efd2000
---------

A new patch will be send. 

> >
> > Signed-off-by: Julio Cruz <jcsistemas2001@gmail.com>
