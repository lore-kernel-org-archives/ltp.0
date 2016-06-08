From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 13:08:32 +0200
Subject: [LTP] ltp-full-20160510 compile failed
In-Reply-To: <404843569.4500543.1465371748586.JavaMail.zimbra@redhat.com>
References: <20160518082726.GA3920@localhost.localdomain>
 <1923642895.3898894.1463574897794.JavaMail.zimbra@redhat.com>
 <20160518145325.GC17880@rei.lan> <20160607161258.GB4397@rei.lan>
 <404843569.4500543.1465371748586.JavaMail.zimbra@redhat.com>
Message-ID: <20160608110815.GC8483@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Jan: Can you have a look?
> 
> ACK. Worked for me.

Pushed.

> I keep thinking if we can avoid all this makefile
> generation.

I do not like it that much either, but given that that we have to stick
to POSIX make (that does not need to implement include keyword) there
and that the generator kind of works I'm not tempted to rewrite it
anytime soon.

In practice the include and ifdef constructs are supported in GNU and
BSD make and in a few others, so we may as well start to require them.
But for instance solaris dmake for instance can include files but the
syntax is different...

-- 
Cyril Hrubis
chrubis@suse.cz
