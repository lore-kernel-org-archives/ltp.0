From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Aug 2019 12:35:06 +0200
Subject: [LTP] [PATCH v3 4/4] build: Move
 -Werror-implicit-function-declaration from make to build.sh
In-Reply-To: <20190809100701.GB27030@dell5510>
References: <20190806164523.557-1-pvorel@suse.cz>
 <20190809093354.GA13178@rei.lan> <20190809100701.GB27030@dell5510>
Message-ID: <20190809103506.GB13178@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Shouldn't this be -Werror=implicit-function-declaration ?
> Yes, it is. '${CFLAGS:-' part is POSIX shell substitute (${parameter:-[word]}
> from [1]), the result is '-Werror=implicit-function-declaration' when CFLAGS is
> empty or not set.
> I might change it as

I meant the = after -Werror vs -.

-- 
Cyril Hrubis
chrubis@suse.cz
