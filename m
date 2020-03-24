From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Mar 2020 14:27:19 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200323154907.GB15673@dell5510>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <20200323154907.GB15673@dell5510>
Message-ID: <CAEemH2fpJw0T0qkRrhFos22A_E+seRXtZ6Rp4jvxUthAuTOQ_g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Mon, Mar 23, 2020 at 11:49 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> ...
> > > > > kernel/syscalls/copy_file_range/copy_file_range02.c
> > > > only affect test6 and test7
> > > >  6) Try to copy contents to a file chattred with +i
> > > >  *    flag -> EPERM
> > > >  * 7) Try to copy contents to a swapfile ->ETXTBSY
> > > Yes, it'd be bad to break all tests due it.
>
> > > Here is also problem with swapoff (or maybe chattr, mkswap, swapon; I
> don't
> > > remember), which returns exit code 255 on error, so it's not possible
> to
> > > distinguish this from the case whether command is not available (any
> idea,
> > > how
> > > to fix it?).
>
> > Maybe we could achieve a tst_cmd_available(char *cmd) in the C version?
> > which uses popen() to open a process like: "whereis/which command" and do
> > string parse in the result to see the path(/usr/bin/cmd, /usr/sbin/cmd)
> of
> > the bin if it has been found.
> Or how about loop whole path like whereis/which command? I want to cover
> also
> these "strange systems" (Android and embedded).
>

Yes, looping the whole PATH is necessary. I'd like to go the access() way
which you improved in the last email.


>
> I wonder if to use this all the time (e.g. in safe_run_cmd(), because
> solution
> in tst_run_cmd_fds_() (errno == ENOENT) works most of the time. Maybe
> changing
> exit code 255 to something less common (e.g. INT_MAX - 5).
>

That might be feasible. I hope to hear more voices from others here.
@Cyril @Xu what do you think?


> Do you want to use tst_cmd_available() also  not only as API
>

Hmm. I guess we can add a new filed in tst_test struct as '.cmd_check' to
make the command support checking automatically in the setup() phase.
That's not very needed but better to testcase manage if we do.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200324/41499d34/attachment.htm>
