From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 25 Jan 2021 11:25:25 +0100
Subject: [LTP] [PATCH v3 7/7] can: Update contact details
In-Reply-To: <20210120143723.26483-8-rpalethorpe@suse.com>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-8-rpalethorpe@suse.com>
Message-ID: <e39c4ae6-94df-9162-7357-d125ced72d17@hartkopp.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 20.01.21 15:37, Richard Palethorpe wrote:
> socketcan-users appears to be no more.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Thanks for the cleanup and the rework, Richard!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
(for the entire series)

Best regards,
Oliver

> ---
>   testcases/network/can/filter-tests/00_Descriptions.txt | 5 +++--
>   testcases/network/can/filter-tests/Makefile            | 2 --
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/network/can/filter-tests/00_Descriptions.txt b/testcases/network/can/filter-tests/00_Descriptions.txt
> index 55d213456..9623d29a0 100644
> --- a/testcases/network/can/filter-tests/00_Descriptions.txt
> +++ b/testcases/network/can/filter-tests/00_Descriptions.txt
> @@ -6,5 +6,6 @@ information on the CAN network protocol family PF_CAN is contained in
>   
>   For any issue(s) with CAN tests please write to:
>   <ltp@lists.linux.it>
> -<socketcan-users@lists.berlios.de>,
> -Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
> +Oliver Hartkopp <socketcan@hartkopp.net>
> +Linux-CAN ML <linux-can@vger.kernel.org>
> +
> diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
> index 29aaa3240..bd57c7fff 100644
> --- a/testcases/network/can/filter-tests/Makefile
> +++ b/testcases/network/can/filter-tests/Makefile
> @@ -14,8 +14,6 @@
>   #    You should have received a copy of the GNU General Public License along
>   #    with this program; if not, write to the Free Software Foundation, Inc.,
>   #    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -#  Send feedback to <socketcan-users@lists.berlios.de>
>   
>   top_srcdir		?= ../../../..
>   
> 
