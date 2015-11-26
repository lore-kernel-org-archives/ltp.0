From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Nov 2015 09:38:48 -0500 (EST)
Subject: [LTP] mtest01 parent/child process synchronization issue
In-Reply-To: <565591C8.7060308@redhat.com>
References: <564CACAF.1080201@redhat.com> <5652E62A.3090403@redhat.com>
 <565591C8.7060308@redhat.com>
Message-ID: <7533547.18002409.1448548727996.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Jiri Vohanka" <jvohanka@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>, ltp@lists.linux.it
> Sent: Wednesday, 25 November, 2015 11:47:36 AM
> Subject: Re: [LTP] mtest01 parent/child process synchronization issue
> 
> Hi,

Hi,

pushed with some changes, see comments below.

> 
> >> diff --git a/testcases/kernel/mem/mtest01/mtest01.c
> >> b/testcases/kernel/mem/mtest01/mtest01.c
> >> index 8c9e81c..06f41d5 100644
> >> --- a/testcases/kernel/mem/mtest01/mtest01.c
> >> +++ b/testcases/kernel/mem/mtest01/mtest01.c
> 
> >> @@ -51,9 +51,12 @@
> >>   char *TCID = "mtest01";
> >>   int TST_TOTAL = 1;
> >>   int pid_count = 0;
> >> +int oom_count = 0;
> >
> > both of these should be static
> 
> You are right, I also added volatile just to be sure.

I changed it to:
  static sig_atomic_t sigchld_count;

> 
> >> @@ -284,7 +288,9 @@ int main(int argc, char *argv[])
> >>   			kill(pid_list[i], SIGKILL);
> >>   			i++;
> >>   		}
> >> -		if (dowrite)
> >> +		if (oom_count)
> >> +			tst_resm(TFAIL, "the child process was killed");
> >
> > I wouldn't combine two "if"s into one if else block, the information how
> > much was allocated could be useful even when we hit OOM.
> 
> The original_maxbytes tells us how much we want to allocate, not how much was
> already allocated. You have to watch TINFO messages emitted by
> child processes to see what was actually allocated. I think that printing
> ""%llu kbytes allocated" would be misleading since that is true only
> if the test passes. I kept the if statement at its current place, but I made
> the fail message more verbose.

You're right, printing orig_maxbytes is useless.

> 
> > But mainly, problem here is that ~6 lines above child processes get killed,
> > so you are racing with SIGCHLD here. I'd suggest to move this TFAIL before
> > kill() loop.
> 
> I moved the part that kills the child processes after PASS/FAIL evaluation to
> avoid possible race condition.
> (Another option would be to uninstall the SIGCHLD signal handler before
> killing the processes.)
> 
> >> +		else if (dowrite)
> >>   			tst_resm(TPASS, "%llu kbytes allocated and used.",
> >>   				 original_maxbytes / 1024);
> >>   		else
> 
> I am new to the list and I am not sure what the rules for posting patches
> are. Should I use 'git send-email', sign the patch or something?

Yes, also good start is to check out "style-guide.txt" and
"test-writing-guidelines.txt" in doc directory.

Regards,
Jan

> 
> Regards,
> Jiri
> 
