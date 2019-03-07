From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Mar 2019 11:59:33 +0100
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <20190306215859.66044-1-saravanak@google.com>
References: <20190306215859.66044-1-saravanak@google.com>
Message-ID: <20190307105933.GA1040@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	ltpuser = SAFE_GETPWNAM(username);
> -	uid = ltpuser->pw_uid;
> +	if (!tst_run_cmd(cmd_useradd, NULL, NULL, 1)) {
> +		user_added = 1;
> +		ltpuser = SAFE_GETPWNAM(username);
> +		uid = ltpuser->pw_uid;
> +	}

The only thing that I don't like here is that we do not check the cause
of failure here. What exactly happens on android, is useradd missing
there completely? If so we should proceed with TCONF only if
tst_run_cmd() returned 255 and TBROK the test on other non-zero return
values.

-- 
Cyril Hrubis
chrubis@suse.cz
