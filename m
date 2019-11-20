From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Nov 2019 12:35:34 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.0-rc8-4b17a56.cki
 (stable-next)
In-Reply-To: <cki.6D94BD5731.3IAGHB25D8@redhat.com>
References: <cki.6D94BD5731.3IAGHB25D8@redhat.com>
Message-ID: <20191120113534.GC14963@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> One or more kernel tests failed:
> 
>     ppc64le:
>      ??? LTP lite
>      ??? xfstests: ext4

Both logs shows missing files, that may be an infrastructure problem as
well.

Also can we include links to the logfiles here? Bonus points for showing
the snippet with the actual failure in the email as well. I takes a fair
amount of time locating them manually in the pipeline repository, it
would be much much easier just with the links to the right logfile...

-- 
Cyril Hrubis
chrubis@suse.cz
