From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Oct 2017 10:40:55 +0200
Subject: [LTP] [PATCH 1/1] network/rdist01: Use correct variables
In-Reply-To: <20170228212013.3x2ehqwji6qk5em4@dell5510>
References: <20170118120455.7751-1-pvorel@suse.cz>
 <20170228212013.3x2ehqwji6qk5em4@dell5510>
Message-ID: <20171003084055.dxsqfqp7x2dqhkmh@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/network/tcp_cmds/rdist/rdist01 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)

> > diff --git a/testcases/network/tcp_cmds/rdist/rdist01 b/testcases/network/tcp_cmds/rdist/rdist01
> > index 4bc239f98..9fdaf1bed 100755
> > --- a/testcases/network/tcp_cmds/rdist/rdist01
> > +++ b/testcases/network/tcp_cmds/rdist/rdist01
> > @@ -135,10 +135,10 @@ check_result()
> >                  TOTAL_SUM=$(( $TOTAL_SUM + $i ))
> >              done
> >              if [ $TOTAL_SUM -eq $LSUM ]; then
> > -                tst_resm TINFO "Success rdist in $c_ruser@$c_rhost "
> > +                tst_resm TINFO "Success rdist in $c_ruser@$c_rhost"
> >                  rsh -n -l $c_ruser $c_rhost "rm -rf $FILES"
> >              else
> > -                end_testcase "Wrong sum doing rdist in $curr_ruser@$curr_rhost"
> > +                end_testcase "Wrong sum doing rdist in $c_ruser@$c_rhost"
> >              fi
> >         done
> >     done

> Ping. Or is it needed to rewrite test?
Ping again.


Kind regards,
Petr
