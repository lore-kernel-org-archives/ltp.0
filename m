From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Apr 2020 15:47:22 +0200
Subject: [LTP] [PATCH v2] Add test for CVE 2018-9568
In-Reply-To: <1ed0003e-126f-5c3d-0fdf-9e41ea9ff1eb@suse.cz>
References: <20200416122023.20952-1-mdoucha@suse.cz>
 <20200416133020.GA15339@yuki.lan>
 <1ed0003e-126f-5c3d-0fdf-9e41ea9ff1eb@suse.cz>
Message-ID: <20200416134722.GB15339@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also looking at spdx.org GPL-2.0 is not valid and it should be
> > GPL-2.0-only.
> 
> I guess we should also ask Andrew Lutomirsky which licence to use in
> ptrace08 then.

Older documentation seems to refer to it as GPL-2.0, as well as '+' was
replaced with '-or-later' so I guess that they changed the identifier to
GPL-2.0-only. And we do have a few GPL-2.0 so these should be replaced
with GPL-2.0-only.

-- 
Cyril Hrubis
chrubis@suse.cz
