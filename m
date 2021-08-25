From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 14:20:49 +0200
Subject: [LTP] [PATCH 3/3] Add test for CVE 2021-3609
In-Reply-To: <025997b0-e0a8-d450-e387-f1a2e8a720e9@suse.cz>
References: <20210825104300.15255-1-mdoucha@suse.cz>
 <20210825104300.15255-3-mdoucha@suse.cz> <87k0k9lpld.fsf@suse.de>
 <025997b0-e0a8-d450-e387-f1a2e8a720e9@suse.cz>
Message-ID: <YSY1oaE3794Asrp8@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think you dropped NS due to lack of CAN support on older kernels?
> 
> Exactly. If I create a new network namespace, SAFE_SOCKET() will fail
> with EAFNOSUPPORT on kernel 4.4.

Then I guess that we have to remove the needs_kconfig before pushing,
right?

-- 
Cyril Hrubis
chrubis@suse.cz
