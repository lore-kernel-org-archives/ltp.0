From: Han Ning <ningx.han@intel.com>
Date: Mon, 5 Dec 2016 08:56:09 +0800
Subject: [LTP] [PATCH ltp] su01: do pre-checking to avoid annoying
 warnings
In-Reply-To: <20161202074508.7rmxhvuezm5aqyze@x230>
References: <AAAF599D7BFC7245B4AE22D9263FF7FB36C97CA3@shsmsx102.ccr.corp.intel.com>
 <20161202074508.7rmxhvuezm5aqyze@x230>
Message-ID: <20161205005609.GA6550@ninghanx>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Dec 02, 2016 at 03:45:08PM +0800, Petr Vorel wrote:
Hi,

> Hi,
> 
> > do pre-checking of file/directory/user to avoid warnings like:
> > mkdir: cannot create directory '/home/su_usr1': File exists
> 
> > Signed-off-by: Ning Han <ningx.han@intel.com>
> > ---
> > testcases/commands/su/su01 | 12 ++++++------
> > 1 file changed, 6 insertions(+), 6 deletions(-)
> 
> > diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
> > index dd1517f..9510f29 100755
> > --- a/testcases/commands/su/su01
> > +++ b/testcases/commands/su/su01
> > @@ -85,8 +85,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
> >  #Create 1st test user
> >      #erase user if he may exist , so we can have a clean en
> > -        rm -rf /home/$TEST_USER1
> > -        userdel $TEST_USER1
> > +        [ -e /home/$TEST_USER1 ] && rm -rf /home/$TEST_USER1
> -f parameter doesn't produce any error message (ignore nonexistent files).
Thanks. With -p parameter it never prompts. Checking is not necessary.
Let's remove it.
> 
> > +        getent passwd $TEST_USER1 && userdel $TEST_USER1
> >                sleep 1
> >          useradd -m -g users $TEST_USER1
> > @@ -105,7 +105,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
> >                then {
> >            USER_UID=`id -u $TEST_USER1`
> >            USER_GID=`id -g $TEST_USER1`
> > -          mkdir $TEST_USER1_HOMEDIR
> > +          [ -e $TEST_USER1_HOMEDIR ] || mkdir $TEST_USER1_HOMEDIR
> Use -p parameter?
'useradd -m' has created user's home directory in our environment.
> 
> >            chown -R $USER_UID.$USER_GID $TEST_USER1_HOMEDIR
> >                }
> >                fi
> > @@ -120,8 +120,8 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
> >  #Create 2nd test user
> >                #erase user if he may exist , so we can have a clean en
> > -        rm -rf /home/$TEST_USER2
> > -        userdel $TEST_USER2
> > +        [ -e /home/$TEST_USER2 ] && rm -rf /home/$TEST_USER2
> > +        getent passwd $TEST_USER2 && userdel $TEST_USER2
> >                sleep 1
> >          useradd -m -g users $TEST_USER2
> > @@ -141,7 +141,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
> >          then {
> >            USER_UID=`id -u $TEST_USER2`
> >            USER_GID=`id -g $TEST_USER2`
> > -          mkdir $TEST_USER2_HOMEDIR
> > +          [ -e $TEST_USER2_HOMEDIR ] || mkdir $TEST_USER2_HOMEDIR
> >            chown -R $USER_UID.$USER_GID $TEST_USER2_HOMEDIR
> >                }
> >                fi
> 
> 
> Kind regards,
> Petr


