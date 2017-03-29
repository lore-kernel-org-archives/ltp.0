From: Steve East <sge@cray.com>
Date: Wed, 29 Mar 2017 17:00:27 +0000
Subject: [LTP] Out-of-tree build missing some data files.
In-Reply-To: <20170329133156.GF7089@rei.lan>
References: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170328133708.GF1045@rei>
 <BN6PR11MB20517B46C814B90AB73E3D43CD320@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170329133156.GF7089@rei.lan>
Message-ID: <BN6PR11MB20512A7C76A7882343FFDE98CD350@BN6PR11MB2051.namprd11.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Wednesday, March 29, 2017 8:32 AM
> To: Steve East <sge@cray.com>
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] Out-of-tree build missing some data files.
> 
> Hi!
> > Unfortunately, this doesn't seem to have had any effect. Changes were...
> >
> > -INSTALL_TARGETS                := $(wildcard file*)
> > +INSTALL_TARGETS                := $(wildcard $(abs_srcdir)/*.in)
> >
> > -INSTALL_TARGETS                := $(wildcard *.c)
> > +INSTALL_TARGETS                := $(wildcard $(abs_srcdir)/*.c)
> 
> Looking into the build system env_post.mk these are prefixed with
> abs_srcdir automatically there so changing these to simply '*.c' or
> '*.in' fixes the problem.
> 
> This patch fixes the installation for me:

Pulled the latest version and it's building nicely.

Thanks,
Steve.

