/* 
 * Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */
package org.ngrinder.common.exception;

/**
 * Exception which will occurs there is no elements in sth.
 * 
 * @author JunHo Yoon
 * @since 3.0
 */
public class NoElementFoundException extends NGrinderRuntimeException {

	private static final long serialVersionUID = 484963219098378067L;

	/**
	 * Constructor.
	 * 
	 * @param message
	 *            message
	 */
	public NoElementFoundException(String message) {
		super(message);
	}

	/**
	 * Constructor.
	 * 
	 * @param message
	 *            message
	 * @param t
	 *            root cause
	 */
	public NoElementFoundException(String message, Throwable t) {
		super(message, t);

	}
}
