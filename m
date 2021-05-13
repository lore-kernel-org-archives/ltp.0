From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 13 May 2021 11:47:14 +0200
Subject: [LTP] [PATCH] syscalls/mallinfo01: Disable free fastbin blocks
In-Reply-To: <609CF8E0.2030408@fujitsu.com>
References: <1620896054-26151-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <96c15b88-4251-5794-03e0-12bcc048fa5e@suse.cz>
 <609CF8E0.2030408@fujitsu.com>
Message-ID: <YJz1oq8otyPa1Spj@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>   I don't have a proper fix. So you can remove it from runtest file.

I've pushed a patch that removes it from the runtest file, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
