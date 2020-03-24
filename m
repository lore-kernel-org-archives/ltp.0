From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Mar 2020 00:51:51 +0100
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200323160415.GC15673@dell5510>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510>
Message-ID: <20200324235150.GC4521@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Something like this would work on whole PATH.
> It's just a question if we want to use it.
> 
> int tst_cmd_available(char *cmd)
> {
> 	char *dup = strdup(getenv("PATH"));
> 	char *s = dup;
> 	char *p = NULL;
> 	int ret = 0;
>     char path[PATH_MAX];
> 
> 	do {
> 		p = strchr(s, ':');
> 		if (p != NULL) {
> 			p[0] = 0;
> 		}
> 		snprintf(path, PATH_MAX, "%s/%s", s, cmd);
> 
> 		if (!access(path, X_OK)) {
> 			ret = 1;
> 			break;
> 		}
> 		s = p + 1;
> 	} while (p != NULL);
> 
> 	free(dup);
> 	return ret;
> }

We already do have tst_get_path() that does more or less the same.

Also if we are going to add this functionality it should be added as an
.needs_cmds array in the tst_test structure.

-- 
Cyril Hrubis
chrubis@suse.cz
