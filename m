From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 17:33:56 +0200
Subject: [LTP] [PATCH V3 15/23] Add periodic output for long time test.
In-Reply-To: <f0c697a5-af36-f468-1a09-376928156fd4@enea.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-15-raj.khem@gmail.com>
 <20160727143744.GD11986@rei.lan>
 <f0c697a5-af36-f468-1a09-376928156fd4@enea.com>
Message-ID: <20160727153356.GG11986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch was needed to avoid the timeout of the script used to parse
> the redirected output of the test. That being said don't have any strong
> arguments (pro or cons) of cleaning up or improving the patch.
> To be pedantic, I think that a newline for every 10 minutes is a little
> too seldom; maybe just adding a new line every 5 minute is acceptable.

Newline per five lines is OK as well. Having 12 lines of output is still
much better than having 60.

-- 
Cyril Hrubis
chrubis@suse.cz
