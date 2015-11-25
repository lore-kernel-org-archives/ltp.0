From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Nov 2015 12:20:47 +0300
Subject: [LTP] [PATCH V3] controllers/pids: Add new testcases
In-Reply-To: <1448026487-6079-1-git-send-email-chnyda@suse.com>
References: <1448026487-6079-1-git-send-email-chnyda@suse.com>
Message-ID: <56557D6F.80906@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 11/20/2015 04:34 PM, Cedric Hnyda wrote:
> Created new testcases to test the pids controller
> which is used to stop any new tasks from being fork()'d
> after a certain limit is reached.
>
> Signed-off-by: Cedric Hnyda <chnyda@suse.com>
...
> index 0000000..6500363
> --- /dev/null
> +++ b/testcases/kernel/controllers/pids/Makefile
> @@ -0,0 +1,28 @@
> +#
> +#    Copyright (C) 2015, SUSE
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
You could write the last paragraph as follows:

# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

or, I guess, we may skip it. The main reason - the address can be changed.

> +
> +	while (1) {
> +	}

Is it necessary to add a busy loop to completely load CPU? If we only 
wait, I would add a sleep, something like

while (1)
      usleep(10);


Thanks,
Alexey
