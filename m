From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 21 Jun 2019 16:00:10 +0200
Subject: [LTP] [PATCH v5 2/4] syscalls/fanotify14: new test to validate
 FAN_REPORT_FID interface return values
In-Reply-To: <98bc3a5d9591387964b913c497f930a11ea4f7a8.1561018312.git.mbobrowski@mbobrowski.org>
References: <cover.1561018312.git.mbobrowski@mbobrowski.org>
 <98bc3a5d9591387964b913c497f930a11ea4f7a8.1561018312.git.mbobrowski@mbobrowski.org>
Message-ID: <20190621140009.GA26200@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#else
> +	TST_TEST_TCONF("System does not have required fanotify support")
                                                                        ^
							I've added
							missing
							semicolon here.
> +#endif

And applied whole patchset together with the fix from Amir.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
