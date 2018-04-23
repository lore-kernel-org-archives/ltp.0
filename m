From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 23 Apr 2018 14:51:50 +0200
Subject: [LTP] [RFC PATCH 1/9] testcases: su: Fix userdel use
In-Reply-To: <20180423101309.GC24481@rei>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
 <20180423094639.14612-2-mylene.josserand@bootlin.com>
 <20180423101309.GC24481@rei>
Message-ID: <20180423145150.3e1c9fdc@windsurf>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On Mon, 23 Apr 2018 12:13:09 +0200, Cyril Hrubis wrote:

> > diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
> > index 34386d937..1eedcb636 100755
> > --- a/testcases/commands/su/su01
> > +++ b/testcases/commands/su/su01
> > @@ -86,7 +86,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
> >  #Create 1st test user
> >      #erase user if he may exist , so we can have a clean en
> >          rm -rf /home/$TEST_USER1
> > -        getent passwd $TEST_USER1 > /dev/null 2>&1 && userdel $TEST_USER1
> > +        getent passwd $TEST_USER1 > /dev/null 2>&1
> > +	userdel $TEST_USER1  
> 
> I'm pretty sure this was intended to be:
> 
> "delete user only if it exists already"
> 
> So the whole getent line is useless after this change.

Perhaps the getent line can be replaced with something like:

grep -q "^$TEST_USER1:" /etc/passwd && userdel $TEST_USER1

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
