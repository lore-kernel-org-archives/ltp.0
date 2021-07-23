From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 23 Jul 2021 14:03:35 +0200
Subject: [LTP] [PATCH 5.13 000/156] 5.13.5-rc1 review
In-Reply-To: <CA+G9fYt_9nfDcQzKm8SZtmQXzzrybutS9vD4GgUw_0o8UD1HOQ@mail.gmail.com>
References: <20210722155628.371356843@linuxfoundation.org>
 <CA+G9fYt_9nfDcQzKm8SZtmQXzzrybutS9vD4GgUw_0o8UD1HOQ@mail.gmail.com>
Message-ID: <YPqwF7wtM6n3wHlr@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 23, 2021 at 05:26:22PM +0530, Naresh Kamboju wrote:
> On Thu, 22 Jul 2021 at 22:17, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.13.5 release.
> > There are 156 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 24 Jul 2021 15:56:00 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.5-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> The following error is due to SATA drive format failing with arm64 64k-page
> size ( CONFIG_ARM64_64K_PAGES=y ) kernel.
> while running LTP syscalls test suite on running 5.13.3 and 5.13.5-rc1 kernel.
> 
> First it was noticed on the stable-rc 5.13.3-rc2 kernel.
> 
> Whereas 64bit kernel and 32bit kernel pass with 4K page size.
> 
> Initially, I thought it could be a Hard drive fault but it is reproducible on
> other devices but not always. Which is a blocker to bisect the problem.
> 
> The steps to reproduce:
>  - Boot arm64 juno device with 64k page stable-rc 5.13 kernel Image [1]
>    - CONFIG_ARM64_64K_PAGES=y
>  - format connected SATA drives and mount /scratch
>  - Use the mounted /scratch for LTP runs to create and delete files from this
>  - cd /opt/ltp
>  - ./runltp -d /scratch -f syscalls

And does that also fail for 5.13.2?

