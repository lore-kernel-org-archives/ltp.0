From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Tue, 22 Oct 2019 14:31:44 +0200
Subject: [LTP] [PATCH v4 4/5] Add newlib shell test for
 tst_multiply_timeout()
In-Reply-To: <20191022080830.GA17235@dell5510>
References: <20191018124502.25599-1-cfamullaconrad@suse.de>
 <20191018124502.25599-5-cfamullaconrad@suse.de>
 <20191022080830.GA17235@dell5510>
Message-ID: <1571747504.24936.2.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2019-10-22 at 10:08 +0200, Petr Vorel wrote:
> Hi,
> 
> > +do_test()
> > +{
> > +	LTP_TIMEOUT_MUL=2
> > +	local sec=1
> > +
> > +	call_it 'tst_multiply_timeout sec' 'sec' 2
> 
> still some issue with this patchset. Making the function private
> (_tst_multiply_timeout), we obviously get warning:
> test_timeout_mul 1 TWARN: Private variable or function
> _tst_multiply_timeout used!
> 
> Unless we want to to add some special variable for library tests
> (i.e. TST_IGNORE_WARN), the function cannot be used directly
> 
> I suggest to push the patchset change to use float (not to be
> postponed even
> more), but without this patchset. Tests should be later added.

+1

