From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Jan 2021 11:41:48 +0100
Subject: [LTP] [PATCH v2 1/1] configure.ac: More descriptive NUMA error
 message
In-Reply-To: <20210121103727.28534-1-pvorel@suse.cz>
References: <20210121103727.28534-1-pvorel@suse.cz>
Message-ID: <YAlabAZEuX6DbSur@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Some people were confused and searched for libnuma.so.2,
> which does not exist.
> 
> Required is libnuma.so.1, but with LIBNUMA_API_VERSION >= 2.
> The API version is tighten to libnuma version in git, but that has
> nothing to do with library soname version, which is still 1.0.0.
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

I consider this safe for the release, please push.

-- 
Cyril Hrubis
chrubis@suse.cz
