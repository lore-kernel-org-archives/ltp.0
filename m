From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Jul 2017 12:12:26 +0200
Subject: [LTP] [RFC PATCH v7 03/11] network/stress: Simplify
 make_background_tcp_traffic usage
In-Reply-To: <cc06aeac-fe9c-dc3d-232b-619b5143e44b@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-4-pvorel@suse.cz>
 <cc06aeac-fe9c-dc3d-232b-619b5143e44b@oracle.com>
Message-ID: <20170725101226.naqjbypzwqzguoq7@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > -	make_background_tcp_traffic
> > -
> >  	local cnt=1
> >  	while [ $cnt -le $NS_TIMES ]; do
> > +		make_background_tcp_traffic

> >  		case $cmd_type in
> >  		if_cmd)
> > @@ -85,9 +84,6 @@ test_body()

> >  		cnt=$(($cnt + 1))

> > -		# Check the background TCP traffic
> > -		pgrep -x netstress > /dev/null || make_background_tcp_traffic


> Does 'make_background_tcp_traffic()' function check that background
> traffic is not running already?

Sure, I just moved your pgrep check into function (it's in the same commit):
make_background_tcp_traffic()
{
	pgrep -x netstress > /dev/null && return

	local port=$(tst_get_unused_port ipv${ipver} stream)
	local ip="${1:-$(tst_ipaddr)}"

	netstress -R 3 -g $port > /dev/null 2>&1 &
	tst_rhost_run -s -c "netstress -l -H $ip -g $port"
}


Kind regards,
Petr
