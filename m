From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Apr 2016 15:07:12 +0200
Subject: [LTP] [PATCH] waitpid/waitpid10: break test if fork failed
In-Reply-To: <20160414053923.GH17476@localhost.localdomain>
References: <20160413071111.GA26897@localhost.localdomain>
 <20160413123625.GD10941@rei.lan>
 <20160414053923.GH17476@localhost.localdomain>
Message-ID: <20160419130712.GA21282@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -330,6 +331,8 @@ int main(int ac, char **av)
>  				}
>  			}
>  
> +			memset(fork_kid_pid, 0, sizeof(fork_kid_pid));

If you memset the array here the test will fail since it's used in the
loop below to check the results.

And looking at the test code it's broken beyond repair. It would likely
be easier to rewrite it from scratch than trying to fix all problems it
has.

-- 
Cyril Hrubis
chrubis@suse.cz
