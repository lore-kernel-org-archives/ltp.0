From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Apr 2021 16:34:03 +0200
Subject: [LTP] [PATCH 4/4] RFC: Add helper functions for managing
 network interfaces
In-Reply-To: <81575a8a-5fa2-78ce-e1b1-e43b4ba45527@suse.cz>
References: <20210426111918.4304-1-mdoucha@suse.cz>
 <20210426111918.4304-5-mdoucha@suse.cz> <YIk4qL+lBIKt+4tX@yuki>
 <81575a8a-5fa2-78ce-e1b1-e43b4ba45527@suse.cz>
Message-ID: <YIlyW4eg417gH2C9@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks, I'll apply the fixes and suggestions before I resubmit. Do you
> have any comments on the header files from API user's perspective?

The API looks reasonable, apart from the minor name changes I've pointed
out and shortening netdevice to just netdev.

Actually having a second look it may make sense to put the netlink
into a separate library probably to libs/libltpnl/

-- 
Cyril Hrubis
chrubis@suse.cz
