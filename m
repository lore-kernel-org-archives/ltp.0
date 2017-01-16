From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 11:27:34 +0100
Subject: [LTP] [PATCH v2 2/2] make: print compiler version
In-Reply-To: <20170113090706.29130-2-pvorel@suse.cz>
References: <20170113090706.29130-1-pvorel@suse.cz>
 <20170113090706.29130-2-pvorel@suse.cz>
Message-ID: <20170116102733.GD20956@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I thought it might be useful for non-travis builds to see from logs compiler
> version.

I'm not against this, but priting it as a first line after make does not
feel right. Maybe we can print some summary (compiler version, enabled
devel libraries) at the end of the configure script. But I do not think
that this will be useful enough to spend significant amout of time on
it.

-- 
Cyril Hrubis
chrubis@suse.cz
