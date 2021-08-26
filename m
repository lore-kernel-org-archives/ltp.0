From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Aug 2021 13:43:16 +0200
Subject: [LTP] [PATCH 3/3] Add test for CVE 2021-3609
In-Reply-To: <57a4f942-a97e-c82b-8a63-1da862eca168@suse.cz>
References: <20210825104300.15255-1-mdoucha@suse.cz>
 <20210825104300.15255-3-mdoucha@suse.cz> <87k0k9lpld.fsf@suse.de>
 <025997b0-e0a8-d450-e387-f1a2e8a720e9@suse.cz>
 <YSY1oaE3794Asrp8@yuki>
 <57a4f942-a97e-c82b-8a63-1da862eca168@suse.cz>
Message-ID: <YSd+VBltKIv32SlI@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Then I guess that we have to remove the needs_kconfig before pushing,
> > right?
> 
> Yes, please. I forgot to remove needs_kconfig after rewriting setup()
> and cleanup() 5 times...

Pushed with the namspace requirements removed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
