From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 Oct 2016 17:43:42 +0200
Subject: [LTP] new shell library
In-Reply-To: <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
References: <20161003145835.GD7583@rei.suse.cz>
 <1484818671.202716.1475571733691.JavaMail.zimbra@redhat.com>
 <20161004093549.GC29418@rei.lan>
 <254451816.211402.1475574875165.JavaMail.zimbra@redhat.com>
 <20161012100806.GA24231@rei.lan>
 <1175646125.448517.1476268354007.JavaMail.zimbra@redhat.com>
 <20161012123602.GB24231@rei.lan> <20161012131726.GC24231@rei.lan>
 <1527497475.514457.1476284084454.JavaMail.zimbra@redhat.com>
Message-ID: <20161013154342.GA20185@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Just FYI, I've added support for positional arguments, since many shell
tests use these, and tried to convert two of these. See:

https://github.com/metan-ucw/ltp/commit/3860c62e4f1ca6aa2f352ec50dd7087fa75b4487
https://github.com/metan-ucw/ltp/commit/5203cc54bbc64125a1c18ab93a4d13347609dc6e
https://github.com/metan-ucw/ltp/commit/3b7092f76e183627b3bb028bd5a8064e518d469a

-- 
Cyril Hrubis
chrubis@suse.cz
