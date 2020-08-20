From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Aug 2020 13:05:50 +0200
Subject: [LTP] [PATCH 1/1] tst_kvcmp: Fix parsing format for
 /etc/os-release
In-Reply-To: <20200820104623.GB9000@yuki.lan>
References: <20200820100238.15925-1-pvorel@suse.cz>
 <20200820104623.GB9000@yuki.lan>
Message-ID: <20200820110550.GA20024@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Po-Hsu,

> >  	if (access(OSRELEASE_PATH, F_OK) != -1) {
> > -		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
> > +		SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=\"%[^\"]\"",
> > +				      distname);

> I guess like opensuse is the only one that uses double quotes there.
> Does this actually work on, for example debian, that has ID=debian in
> the /etc/os-release?
No, sorry for overlooking that.

> I guess that it may be actually easier to optionaly strip the double
> quotes after the scanf().
+1, I'll send v2.

Kind regards,
Petr
