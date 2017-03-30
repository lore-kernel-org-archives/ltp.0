From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 30 Mar 2017 14:06:33 +0200
Subject: [LTP] Out-of-tree build missing some data files.
In-Reply-To: <20170330105920.GC12095@rei.lan>
References: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170328133708.GF1045@rei>
 <BN6PR11MB20517B46C814B90AB73E3D43CD320@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170329133156.GF7089@rei.lan>
 <BN6PR11MB20512A7C76A7882343FFDE98CD350@BN6PR11MB2051.namprd11.prod.outlook.com>
 <CAEemH2cMoGycJxb13zDBP9xijMb5p2OfyTXsXUom-n8zJNFboQ@mail.gmail.com>
 <20170330105920.GC12095@rei.lan>
Message-ID: <20170330120633.rnnjeib7h5qmqbac@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > 1. The open_posix_testuite is also compiling in this time, but I
> > remember I didn't pass any parameter to config that.

> I noticed it as well, my guess is that this was broken by:
> https://github.com/linux-test-project/ltp/issues/143

I'm working on the fix of open_posix_testuite out-of-tree build. There are other issues
than gh#143.


Kind regards,
Petr

