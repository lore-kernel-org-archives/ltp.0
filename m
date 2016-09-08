From: Zorro Lang <zlang@redhat.com>
Date: Thu, 8 Sep 2016 22:08:14 +0800
Subject: [LTP] [PATCH] runltp: add -R option for randomize test order
In-Reply-To: <20160908131706.GA23863@rei>
References: <1473339202-3047-1-git-send-email-zlang@redhat.com>
 <20160908131706.GA23863@rei>
Message-ID: <20160908140814.GB12847@dhcp12-143.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 08, 2016 at 03:17:06PM +0200, Cyril Hrubis wrote:
> Hi!
> > +#######################################################################
> > +# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation; either version 2 of
> > +# the License, or (at your option) any later version.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, see <http://www.gnu.org/licenses/>.
> > +#
> > +# Author: Zorro Lang <zlang@redhat.com>
> > +#
> > +#######################################################################
> > +
> > +# randomize all lines of stdin
> > +
> > +function randomize(array, N) {
> > +	for(i = 0; i < N; i++) {
> > +		j = int(rand()*N)
> > +		if ( i != j) {
> > +			tmp = array[i]
> > +			array[i] = array[j]
> > +			array[j] = tmp
> > +		}
> > +	}
> > +	return
> > +}
> > +
> > +{
> > +	array[NR] = $0
> > +}
> > +
> > +END {
> > +	srand()
> > +	randomize(array, NR)
> > +	for(i = 0; i < NR; i++) printf("%s\n", array[i])
> > +}
> 
> This is absurdly complicated for the task it does.
> 
> Newer GNU coreutils has shuf that does exactly what you want and there
> is short -R as well, that more or less does what you want (the sort is
> random unless there are duplicated lines in the input).

What stupid things I have done, I forgot 'sort' command o_O
Thanks for point that, I'll send a V2 patch and go to bed...

Thanks,
Zorro

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
