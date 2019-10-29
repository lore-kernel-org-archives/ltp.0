From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 29 Oct 2019 09:20:28 +0100
Subject: [LTP] [PATCH 4.19 00/93] 4.19.81-stable review
In-Reply-To: <CA+G9fYuA+kLqLo1_ev0=QRvYtMrVhwRvm+QO-tOCVYca2Mt97Q@mail.gmail.com>
References: <20191027203251.029297948@linuxfoundation.org>
 <CA+G9fYuA+kLqLo1_ev0=QRvYtMrVhwRvm+QO-tOCVYca2Mt97Q@mail.gmail.com>
Message-ID: <20191029082028.GA554294@kroah.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 29, 2019 at 11:51:26AM +0530, Naresh Kamboju wrote:
> On Mon, 28 Oct 2019 at 02:44, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.19.81 release.
> > There are 93 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Tue 29 Oct 2019 08:27:02 PM UTC.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.81-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Results from Linaro?s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Note:
> The new test case  from LTP version upgrade syscalls sync_file_range02 is an
> intermittent failure. We are investigating this case.
> The listed fixes in the below section are due to LTP upgrade to v20190930.

Thanks for testing two of these and letting me know.

greg k-h
