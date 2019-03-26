From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Mar 2019 14:02:42 +0100
Subject: [LTP] [PATCH] libs: fix sporadic out-of-tree build failures
 related to libs
In-Reply-To: <0334E21D-3339-4827-89EA-3FF74E8EA13D@gmail.com>
References: <3fedf790971b876b20533ee3d6b5dff27b54fae3.1553076284.git.jstancek@redhat.com>
 <20190320162519.GA13644@rei>
 <0334E21D-3339-4827-89EA-3FF74E8EA13D@gmail.com>
Message-ID: <20190326130242.GA22724@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Enji,

> > The problem here is that unless the paths in LTPLIBS_DIRS match existing
> > files the mkdir -p is executed every time LTPLIBS is defined in
> > Makefile. I guess that we can put the absolute paths back to the
> > LTPLIBS_DIRS variable and use $(subst ..) to replace the builddir with
> > srcdir but I wonder if there is a better solution.

> 	I don’t think this isn’t the right way. Memory serves me correctly (it’s been almost a decade), the glue code in …/Makefile is incorrect. This is where the directory needs to be created.
> 	Let me try implementing a fix.
Any progress on this, please?

> Cheers,
> -Enji

Kind regards,
Petr
