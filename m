From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Feb 2019 12:06:42 +0100
Subject: [LTP] [PATCH] setregid01: Fix security warning for string
 formatting
In-Reply-To: <20190225213429.GA5339@x230>
References: <20190225171220.5827-1-daniel.diaz@linaro.org>
 <20190225213429.GA5339@x230>
Message-ID: <20190226110642.GC29783@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Maybe we should have -Wformat -Wformat-security -Werror=format-security as the
> default.

I'm all for it but we have to check if a compiler on oldest supported
distro works fine with these flags, othewise we would have to add a
configure check...

-- 
Cyril Hrubis
chrubis@suse.cz
