From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2016 14:41:52 +0800
Subject: [LTP] LTP release
In-Reply-To: <20160125122804.GC30655@rei.lan>
References: <20160121174101.GD19851@rei.lan> <20160125122804.GC30655@rei.lan>
Message-ID: <CAEemH2c72Qv9GKqDhoXoYHJLA4aLky9K7vDB9kx56EN2TTTpWw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Mon, Jan 25, 2016 at 8:28 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Can we do the release on Monday or Tuesday?
>
> I've just pushed the cgroup_fj fix. Please have a look at it and ideally
> run cgroup_fj the tests today, it should take less than hour.
>
> The only two outstanding issues should now be fallocate04 and ROD with
> redirection. I will have a look at the fallocate04 patch now, then try
> to do something about the ROD redirection.
>

I did a quick ltp/mem[sched] test on RHEL7.2 with upstream-v4.4 kernel, it
works fine except one thp05.c fails.

looks like the issue exist so long time with any kernel on x86_64 numa
system.I just post a simple patch try to fix that.


>
> If nothing else shows up I will tag the git and do the release tomorrow.
>

Fine.


>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160126/99982a58/attachment.html>
