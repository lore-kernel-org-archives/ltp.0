From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Apr 2020 21:23:12 +0800
Subject: [LTP] [PATCH v2 2/2] Skip oversleep checks in timer tests under
 VM
In-Reply-To: <797241805.10630970.1588143297978.JavaMail.zimbra@redhat.com>
References: <20200428154727.29206-1-mdoucha@suse.cz>
 <20200428154727.29206-2-mdoucha@suse.cz>
 <797241805.10630970.1588143297978.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cRhQQL-Z16H37KPOXOuVSV87vAyvKiPYy4ZVK6gA3Rmw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 29, 2020 at 2:55 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > Timer tests often fail on sleep overrun when LTP is running inside a VM.
> > The main cause is usually that the VM doesn't get enough CPU time to
> wake up
> > the test process in time. Disable oversleep tests if tst_is_virt()
> detects
> > any hypervisor.
>
> > BTW, systemd-detect-virt can't detect the PowerPC LPAR hypervisor.
>
> Same with virt-what. We could (in separate patch) add check for
> 'pseries_platform' (powerpc-utils) output:
>

+1 that makes sense to me.


>
> # pseries_platform
> PowerVM pSeries LPAR
>
> # pseries_platform
> PowerNV Host
>
> # pseries_platform
> Power KVM pSeries Guest
>
> >
> > +     /*
> > +      * Running tests in VM may cause timing issues, disable upper bound
> > +      * checks if LTP_VM_ENV is set to non-zero.
> > +      */
> > +     virt_env = tst_is_virt(VIRT_ANY);
>
> The comment still mentions LTP_VM_ENV. Other than that, I don't have major
> objections. Maybe somebody would like to run strict checks on VMs too, but
> that's something we could add later with an env. variable.
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200429/758bab33/attachment.htm>
