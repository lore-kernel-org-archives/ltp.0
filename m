From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Mar 2016 04:42:52 -0400 (EDT)
Subject: [LTP] readahead02 failure on PPC
In-Reply-To: <SN1PR12MB0782C6FC545C11345F3A0B5EEE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
References: <SN1PR12MB078260DD2BC3C2091E1D9893EE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
 <1136739411.10804114.1458249456113.JavaMail.zimbra@redhat.com>
 <SN1PR12MB0782C6FC545C11345F3A0B5EEE8B0@SN1PR12MB0782.namprd12.prod.outlook.com>
Message-ID: <33749902.10876382.1458290572208.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Kshitij Malik" <Kshitij.Malik@mitel.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 17 March, 2016 11:03:23 PM
> Subject: Re: [LTP] readahead02 failure on PPC
> 
> Hi Jan,
> 
> Sorry for the html mails. I will move to the desktop outlook tomorrow to
> avoid this.
> 
> You were right, the issue is because of the 64 bit data being passed in
> syscall. With your patch, I don't see the issue anymore. I ran the test
> again and again (7-8 times) and it is not failing anymore.
> 
> we are a 32 bit ppc system and do we really need this test. Can this test be
> modified such that syscall is called for PPC 64 architecture and readahead
> for 32 bit?

I think best would be to add configure check and use readahead() glibc
function whenever possible.

I'm adding CC on Julio, he reported something similar couple days ago,
I suspect it's the same problem. Julio, can you confirm? (see patch below)

Regards,
Jan

> 
> Thanks
> KK
> ________________________________________
> From: Jan Stancek <jstancek@redhat.com>
> Sent: Thursday, March 17, 2016 17:17
> To: Kshitij Malik
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] readahead02 failure on PPC
> 
> ----- Original Message -----
> > From: "Kshitij Malik" <Kshitij.Malik@mitel.com>
> > To: ltp@lists.linux.it
> > Sent: Thursday, 17 March, 2016 6:40:58 PM
> > Subject: [LTP] readahead02 failure on PPC
> >
> >
> >
> > Hi,
> 
> Hi,
> 
> we prefer plain text over html emails on this list.
> 
> >
> > I'm working on PowerPc based board MPC8360 and we are running 4.1.13
> > kernel.
> 
> and from previous issue you reported, I recall this is 32bit environment.
> 
> > During our LTP run, we saw the following failure with readahead02 test.
> >
> > readahead02 0 TWARN : readahead02.c:353: using less cache than expected
> > The log file is attached to this mail.
> 
> readahead has no effect. It's supposed to read file into cache, so we
> expect change in used cache and that subsequent reads will be faster
> (because data is already in memory).
> 
> >
> > Please note that I'm running the latest LTP code and has the latest
> > readahead02.c patch checked in yesterday.
> > Can you please help me in finding out the solution for this issue?
> 
> Just to confirm, this is not an issue with passing 64bit parameter
> in syscall(), can you try running it with this change and send us output?
> 
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c
> b/testcases/kernel/syscalls/readahead/readahead02.c
> index 7dc308c03e5d..0b42542d0d13 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -236,7 +236,7 @@ static void read_testfile(int do_readahead, const char
> *fname, size_t fsize,
> 
>         if (do_readahead) {
>                 for (i = 0; i < fsize; i += readahead_size) {
> -                       TEST(ltp_syscall(__NR_readahead, fd,
> +                       TEST(readahead(fd,
>                                 (off64_t) i, readahead_size));
>                         if (TEST_RETURN != 0)
>                                 break;
> 
> > Please let me know if you need any other information.
> 
> If that makes no difference, "strace -T" could tell us how much time
> is kernel spending in this syscall.
> 
> There was an issue with readahead on ppc a while ago, where readahead
> was effectively ignored on memory-less nodes, but you should have that
> patch already:
>   commit 6d2be915e589b58cb11418cbe1f22ff90732b6ac
>   Author: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>   Date:   Thu Apr 3 14:48:23 2014 -0700
>     mm/readahead.c: fix readahead failure for memoryless NUMA nodes and limit
>     readahead pages
> 
> Regards,
> Jan
> ________________________________
> NOTE: This e-mail (including any attachments) is for the sole use of the
> intended recipient(s) and may contain information that is confidential
> and/or protected by legal privilege. Any unauthorized review, use, copy,
> disclosure or distribution of this e-mail is strictly prohibited. If you are
> not the intended recipient, please notify Mitel immediately and destroy all
> copies of this e-mail. Mitel does not accept any liability for breach of
> security, error or virus that may result from the transmission of this
> message.
> 
