From: Li Wang <liwang@redhat.com>
Date: Wed, 27 May 2020 16:00:41 +0800
Subject: [LTP] [PATCH v1 1/4] lib: add new cgroup test API
In-Reply-To: <535677442.13762982.1590565251771.JavaMail.zimbra@redhat.com>
References: <20200527031430.22144-1-liwang@redhat.com>
 <535677442.13762982.1590565251771.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2e6Hr7JmdV02P=8SyiVK-q5fHj7=RkF_R8fM+m9b3PrBg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 27, 2020 at 3:40 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
>
> ----- Original Message -----
> > +
> > +void tst_cgroup_mem_set_maxbytes(long memsz)
> > +{
> > +     tst_cgroup_move_current(TST_CGROUP_MEMCG);
>
> It seems a bit unexpected, that setting a limit also moves current
> process to cgroup. If test forks two processes, it has to set maxbytes
> twice, to get the desired side-effect.
>

Yes, I didn't aware of that before.
Maybe we can remove the tst_cgroup_move_current() from here and invoke it
additionally?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200527/c07fc6e5/attachment.htm>
