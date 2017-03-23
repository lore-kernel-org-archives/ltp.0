From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Mar 2017 12:35:30 +0100
Subject: [LTP] [PATCH 1/1] rpc: Add missing header
In-Reply-To: <20170322202820.15989-1-pvorel@suse.cz>
References: <20170322202820.15989-1-pvorel@suse.cz>
Message-ID: <20170323113530.GD351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This fixes: implicit declaration of function ???pmap_unset???.

Hmm, the man 3 rpc only states that <rpc/rpc.h> needs to be included,
what distro this fails on?

-- 
Cyril Hrubis
chrubis@suse.cz
