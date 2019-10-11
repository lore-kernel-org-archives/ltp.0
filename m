From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 11 Oct 2019 14:39:46 +0200
Subject: [LTP] [PATCH v5 0/5] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <20191011095442.10541-1-pvorel@suse.cz>
References: <20191011095442.10541-1-pvorel@suse.cz>
Message-ID: <1570797586.4238.9.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 2019-10-11 at 11:54 +0200, Petr Vorel wrote:
> Hi,
> 
> hopefully the latest version.
> 
> Changes v4->v5:
> * remove float related code (left from v3)
> * remove "tst_test_cmds cut" check from tst_test.sh (there is check
> for
> cut and other later => it should be probably removed as well, but as
> a
> separate patch) (Cyril)
> * remove unneeded IFS from test (Cyril)
> * mention ceiling LTP_TIMEOUT_MUL in doc/user-guide.txt
> 
> 
<snip>

For me this patchset looks good. I only add some nit comments on the
tests, can be taken or not.

Thanks
Clemens

