From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Mar 2021 14:12:39 +0100
Subject: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
In-Reply-To: <YEtK/A2mGoEZjF8Q@pevik>
References: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
 <YEigO2gryF1Kp6Gq@pevik>
 <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
 <YEkAH6xJlSK99bp+@pevik> <YEnx4V3Il/VrThv/@pevik>
 <YEn0BK8xHVU1e52X@yuki.lan> <YEtK/A2mGoEZjF8Q@pevik>
Message-ID: <YEtox4nFn3DO1KHv@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We can add macro expansion to the docparse instead, it shouldn't be that
> > hard.
> Not sure if I understand what you mean. Using gcc -E or something else?

Not really, we can just add a has table and put all macros in there
while we traverse the code. I can prototype code for that later on.

-- 
Cyril Hrubis
chrubis@suse.cz
