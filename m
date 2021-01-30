From: Li Wang <liwang@redhat.com>
Date: Sat, 30 Jan 2021 16:26:25 +0800
Subject: [LTP] [PATCH v2 6/6] zram: Increase timeout according to used
 devices
In-Reply-To: <YBRs9sySYXT6Bwlk@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-7-pvorel@suse.cz>
 <YBRroFhaxdqCLv2i@pevik> <YBRs9sySYXT6Bwlk@pevik>
Message-ID: <CAEemH2foqS4=kTPJ50f2OZmnGU7wn4Kth0Onet-a6EX1J45-Bw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Jan 30, 2021 at 4:16 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi,
>
> > > +   TST_TIMEOUT=$((dev_num*200))
> > Actually on heavy loaded machine this is not enough due BTRFS.
> > I can add something like dev_num*600 or even -1 (then previous commit
> would not
> > be needed, but IMHO still useful).
>

I personally think -1 is better.



> And bad thing is that it breaks other zram tests, because the timer
> probably
> does not allow to run the cleanup:
>
> _tst_setup_timer()
> {
> ...
>         sleep $sec && tst_res TBROK "test killed, timeout! If you are
> running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9
> -$pid &
>
> I'm not sure if shell allow us to do it better. Maybe sent different
> signal than
> SIGKILL and define 'trap _tst_do_exit' for that signal?


Sounds practicable. I guess sending SIGINT could make more sense, since
sometimes we use CTRL+C stop test in debugging by manual, test should
do cleanup work for that behavior too.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210130/5616a62d/attachment-0001.htm>
